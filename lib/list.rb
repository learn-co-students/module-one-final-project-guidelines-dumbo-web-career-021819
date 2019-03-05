require 'pry'
class List < ActiveRecord::Base
  belongs_to :shopper
  has_many :list_items

  ################ .downcase all List and Item names! ##############

  def add_item(name)
    item = Item.find_or_create_by(name: name.downcase)
    list_item = ListItem.find_or_create_by(list_id: self.id, item_id: item.id, still_needed: true)
    "#{item.name.capitalize} - added to your list: #{self.name}!"
  end

  def delete_item(name)
    item = Item.find_by(name: name.downcase)
    if item
      list_item = ListItem.find_by(list_id: self.id, item_id: item.id)
    else
      "#{name.capitalize} doesn't exist."
    end
    if list_item
      list_item.destroy
      "Deleted '#{name.capitalize}'"
    else
      "#{name.capitalize} wasn't on your list: #{self.name}."
    end
  end

  def check_item(name)
    item = Item.find_by(name: name.downcase)
    if item
      list_item = ListItem.find_by(list_id: self.id, item_id: item.id)
    else
      "#{name.capitalize} doesn't exist." #{doesn't get here}
    end
    if list_item #doesn't persist
      list_item.still_needed ? list_item.still_needed = false : list_item.still_needed = true
      list_item.save
    else
      "#{name.capitalize} wasn't on your list."
    end
  end

  def all_listitems
    ListItem.all.where(list_id: self.id)
  end

  def all_needed_listitems
    all_listitems.select {|item| item.still_needed}
  end

  def not_needed_listitems
    all_listitems.reject {|inst| all_needed_listitems.include?(inst)}
  end

  def listitem_to_name(array)
    get_items = array.map(&:item)
    get_items.map(&:name)
  end

  def items
    listitem_to_name(all_needed_listitems)
  end

  alias :all :items #You can all #items OR #all and they do the same thing

  def checked_off
    listitem_to_name(not_needed_listitems)
  end

  def all_items
    listitem_to_name(all_listitems)
  end
end
