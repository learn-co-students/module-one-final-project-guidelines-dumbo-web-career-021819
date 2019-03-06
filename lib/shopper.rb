require 'pry'
class Shopper < ActiveRecord::Base
  has_many :lists
  has_many :list_items, through: :lists

    ################ .downcase Item names! ##############

  def create_list(list_name) #creates a new list
    List.create(name: list_name, shopper_id: self.id)
  end

  def delete_list(name) #doesn't work in console, but works from runner file
    # puts "im in the method"
    # binding.pry
    self.lists.find_by(name: name).destroy
  end

  def delete_shopper # Should it also delete all associated ListItems? YES 
    self.list_items.each do |list_item|
      list_item.destroy
    end
    # self.lists.destroy
    # self.destroy
  end

  def list_names #returns an array of all list names of shopper
    self.lists.map(&:name)
  end

end
