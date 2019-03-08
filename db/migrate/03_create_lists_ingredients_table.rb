class CreateListsIngredientsTable < ActiveRecord::Migration[4.2]
  def change

    create_table :lists_ingredients do |t|
      t.integer :list_id
      t.integer :ingredient_id
      t.boolean :still_needed
    end

  end
end
