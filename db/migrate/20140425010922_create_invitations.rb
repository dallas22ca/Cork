class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.belongs_to :user, index: true
      t.belongs_to :folder, index: true

      t.timestamps
    end
  end
end
