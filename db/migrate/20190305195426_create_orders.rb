class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :restaurant_id
      t.float :total, default: 0.00
      t.string :location
      t.string :delivery_or_takeout
      t.string :cash_or_card
    end
  end
end
