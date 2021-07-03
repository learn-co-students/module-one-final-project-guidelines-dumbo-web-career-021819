class CreateListsTable < ActiveRecord::Migration[4.2]
  def change

    create_table :lists do |t|
      t.string :name
      t.integer :shopper_id #shopper instance?
      
    end

  end
end
