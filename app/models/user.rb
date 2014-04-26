class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  
  has_many :identities
  has_many :invitations
  has_many :folders, through: :invitations
  belongs_to :brokerage
  
  has_attached_file :avatar,
    default_url: "/imgs/user_no_avatar.jpg"
  
  validates_attachment_content_type :avatar, content_type: /jpeg|jpg|gif|png/
  
  accepts_nested_attributes_for :brokerage, reject_if: Proc.new { |b| b["name"].blank? }
  
  before_save :format_website
  
  def format_website
    self.website = "http://#{website}" unless website.blank? || website =~ /http/
  end
  
  def self.from_omniauth(auth)
    identity = Identity.where(auth.slice(:provider, :uid)).first_or_initialize
    identity.username = auth.info.nickname
    
    unless identity.user
      user = User.new
      user.email = auth.info.email unless auth.info.email.blank?
      user.name = auth.extra.raw_info.name
      user.password = Devise.friendly_token[0,20]
      
      unless auth.info.image.blank?
        uri = URI.parse(auth.info.image)
        uri.scheme = 'https'
        user.avatar = URI.parse("#{auth.info.image.gsub("http", "https")}?type=large")
      end
      
      user.save
      identity.user = user
    end
    
    identity.save
    identity.user
  end

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def password_required?
    if identities.blank?
      false
    else
      super
    end
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end
end
