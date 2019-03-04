class Shopper < ActiveRecord::Base
  has_many :lists
  has_many :lists_ingredients, through: :list

  def add_item(list, item)
    #find_or_create_by
  end

  def create_list(name)
    #createlist!
  end

  def check_item(list, item)
  end

  def delete_item(list, item)
  end

end
