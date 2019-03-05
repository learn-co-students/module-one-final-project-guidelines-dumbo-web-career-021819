require 'pry'
class Shopper < ActiveRecord::Base
  has_many :lists
  has_many :list_items, through: :list

    ################ .downcase all List and Item names! ##############

  def create_list(list_name) # it works!
    new_list = List.create(name: list_name.name, shopper_id: self.id)
  end

  def delete_shopper
    self.delete
  end

  def list_names
    #shows array of names of all lists the shopper has
    self.lists.map do |list_instance|
      list_instance.name
    end
  end

end
