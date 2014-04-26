class AddArchiveToFolders < ActiveRecord::Migration
  def change
    add_column :folders, :archive, :boolean, default: false
  end
end
