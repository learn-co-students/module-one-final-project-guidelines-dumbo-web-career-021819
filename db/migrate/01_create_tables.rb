class CreateTables < ActiveRecord::Migration[4.2]
  def change
    create_table :shoppers do |t|
      t.string :name
    end

    create_table :lists do |t|
      t.string :name
      t.integer :shopper_id
    end

    create_table :lists_ingredients do |t|
      t.integer :list_id
      t.integer :ingredient_id
      t.boolean :still_needed
    end

    create_table :ingredients do |t|
      t.string :name
    end

  end
end
