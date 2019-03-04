class CreateShoppersTable < ActiveRecord::Migration[4.2]
  def change

    create_table :shoppers do |t|
      t.string :name
    end
    
  end
end
