class Brokerage < ActiveRecord::Base
  has_many :users # agents
  
  has_attached_file :logo,
    default_url: "/imgs/brokerage_no_logo.jpg"
  
  validates_attachment_content_type :logo, content_type: /jpeg|jpg|gif|png/
  validates_presence_of :name, :website
  
  before_save :format_website
  
  def format_website
    self.website = "http://#{website}" unless website.blank? || website =~ /http/
  end
end
