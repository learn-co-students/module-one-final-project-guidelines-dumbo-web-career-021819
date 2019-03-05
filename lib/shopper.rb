class Shopper < ActiveRecord::Base
  has_many :lists
  has_many :list_items, through: :list

    ################ .downcase all List and Item names! ##############

  def create_list(name) # it works!
    List.create(name: name, shopper_id: self.id)
  end

  def delete_shopper
    self.delete
  end

  def lists
    #shows all lists the shopper has
  end

end
