class RenameIngredientIdToItemId < ActiveRecord::Migration[4.2]
  def change
    rename_column :list_items, :ingredient_id, :item_id
  end
end
