class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menuitems do |t|
      t.float :price
      t.string :description
      t.integer :menu_id
    end
  end
end
