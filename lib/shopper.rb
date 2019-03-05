class Shopper < ActiveRecord::Base
  has_many :lists
  has_many :lists_ingredients, through: :list

  def create_list(name, id)
    List.create(name: name, shopper_id: self.id)
    #will automatically assign shopper_id?
  end

  def delete_shopper
    self.delete
  end

end
