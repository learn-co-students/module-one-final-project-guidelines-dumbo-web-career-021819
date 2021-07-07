class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.integer :restaurant_id
      t.float :total, default: 0.00
      t.string :location
      t.boolean :received?, default: false
      t.string :deliver_or_pickup, default: "deliver"
      t.string :cash_or_card
    end
  end
end
