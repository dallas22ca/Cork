class AddAttachmentLogoToBrokerages < ActiveRecord::Migration
  def self.up
    change_table :brokerages do |t|
      t.attachment :logo
    end
  end

  def self.down
    drop_attached_file :brokerages, :logo
  end
end
