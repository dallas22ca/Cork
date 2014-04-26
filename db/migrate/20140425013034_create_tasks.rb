class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.belongs_to :folder, index: true
      t.belongs_to :creator, index: true
      t.text :content
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
