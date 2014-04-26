class Folder < ActiveRecord::Base
  belongs_to :creator, foreign_key: :creator_id, class_name: "User"
  
  has_many :tasks
  has_many :documents
  has_many :invitations
  has_many :users, through: :invitations
  
  validates_presence_of :name
  
  scope :archived, -> { where(archive: true) }
  scope :active, -> { where(archive: false) }
  
  after_create :add_creator_via_invitation
  
  def add_creator_via_invitation
    invitations.create user: creator
  end
end
