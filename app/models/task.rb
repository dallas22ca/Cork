class Task < ActiveRecord::Base
  belongs_to :creator, foreign_key: :creator_id, class_name: "User"
  belongs_to :folder
end
