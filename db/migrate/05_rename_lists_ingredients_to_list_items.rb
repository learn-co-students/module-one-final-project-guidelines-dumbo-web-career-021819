class RenameListsIngredientsToListItems < ActiveRecord::Migration[4.2]
  def change
    rename_table :lists_ingredients, :list_items
  end
end
