require 'pry'
class List < ActiveRecord::Base
  belongs_to :shopper
  has_many :list_items

  def add_item(name)
    item = Item.find_or_create_by(name: name)
    list_item = ListItem.find_or_create_by(list_id: self.id, item_id: item.id)
    "#{item.name.capitalize} - added to your list: #{self.name}!"
  end



  def delete_item(item)
  end

  def check_item(item)
  end
  # binding.pry
end
