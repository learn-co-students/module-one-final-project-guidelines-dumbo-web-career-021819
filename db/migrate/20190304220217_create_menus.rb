class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :restaurant_id
    end
  end
end
