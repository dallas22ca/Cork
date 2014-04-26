class AddBrokerageToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :brokerage, index: true
  end
end
