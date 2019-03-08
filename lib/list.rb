require 'pry'
class List < ActiveRecord::Base
  belongs_to :shopper
  has_many :list_items
  has_many :items, through: :list_items

  ################ .downcase all List and Item names! ##############

  def add_item(name) #adds item to list
    item = Item.find_or_create_by(name: name.downcase) # adding still_needed: default true to class, not here
    list_item = ListItem.find_or_create_by(list_id: self.id, item_id: item.id) #here causes duplicates
    list_item.update(still_needed: true)
    # "#{item.name.capitalize} - added to your list: #{self.name}!"
    list_item
  end

  def delete_item(name) #deletes item from list
    item = Item.find_by(name: name.downcase)
    list_item = ListItem.find_by(list_id: self.id, item_id: item.id)
    list_item.destroy if (item && list_item)
    #   "Deleted '#{name.capitalize}'"
    # else
    #   "#{name.capitalize} wasn\'t on your list."
    # end
  end

  def check_item(name) # changes the item's still_needed boolean
    if self.item_names.include?(name)
      list_item = ListItem.all.find do |inst|
        inst.item.name == name && inst.list_id == self.id
      end
      list_item.still_needed = !list_item.still_needed
      list_item.save
    # else
    #   "#{name.capitalize} wasn't on your list."
    end
    list_item
  end

  def needed # lists all item names that ARE checked in the list.
    needed_listitems = self.list_items.where(still_needed: true)
    needed_items = needed_listitems.map {|list_item| list_item.item}
    needed_items.map(&:name)
  end

  def checked_off # lists all item names that ARE checked in the list.
    checked_listitems = self.list_items.where(still_needed: false)
    checked_items = checked_listitems.map {|list_item| list_item.item}
    checked_items.map(&:name)
  end

  def item_names
    self.items.map(&:name)
  end

  # def check_off_all
  #   0 #all items become still_needed: false
  # end
  #
  # def need_all
  #   0 #all items become still_needed: true
  # end

end
