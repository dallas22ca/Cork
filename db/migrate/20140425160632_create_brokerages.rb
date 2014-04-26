class CreateBrokerages < ActiveRecord::Migration
  def change
    create_table :brokerages do |t|
      t.string :name
      t.string :website

      t.timestamps
    end
  end
end
