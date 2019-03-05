require 'pry'
class List < ActiveRecord::Base
  belongs_to :shopper
  has_many :lists_ingredients

  def add_item(item)
    ListIngredient.find_or_create_by(name: item, list_id: self.id)
  end

  def delete_item(item)
  end

  def check_item(item)
  end
  # binding.pry
end
