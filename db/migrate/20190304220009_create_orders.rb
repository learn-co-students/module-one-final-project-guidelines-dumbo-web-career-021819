class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :location
      t.integer :customer_id
      t.integer :restaurant_id
      t.boolean :received?
      t.timestamp :created_at
      t.timestamp :updated_at
      t.float :total
    end
  end
end
