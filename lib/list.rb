require 'pry'
class List < ActiveRecord::Base
  belongs_to :shopper
  has_many :list_items

  ################ .downcase all List and Item names! ##############

  def add_item(name) #adds item to list
    item = Item.find_or_create_by(name: name.downcase)
    list_item = ListItem.find_or_create_by(list_id: self.id, item_id: item.id, still_needed: true)
    "#{item.name.capitalize} - added to your list: #{self.name}!"
  end

  def delete_item(name) #deletes item from list (and ItemList?)
    item_instance = item_exists(name)
    if item_exists(name) and is_in_list(item_instance)
      is_in_list(item_instance).destroy
      "Deleted '#{name.capitalize}'"
    else ############DELETES ITEM, NOT LISTITEM!!!
      "#{name.capitalize} wasn\'t on your list."
    end
  end

  def check_item(name) # changes the item's still_needed boolean
    if self.items.include?(name)
      list_item = ListItem.all.find do |inst|
        inst.item.name == name && inst.list_id == self.id
      end
      list_item.still_needed = !list_item.still_needed
      list_item.save
    else
      "#{name.capitalize} wasn't on your list."
    end
  end

  def items #lists all item names that are NOT checked in the list)
    self.list_items.where(still_needed: true).map(&:item).map(&:name)
  end

  alias :list :items  #You can all #items OR #all and they do the same thing
  alias :all_names :items
  alias :all_items :items
  alias :all :items

  def checked_off # lists all item names that ARE checked in the list.
    self.list_items.where(still_needed: false).map(&:item).map(&:name)
  end

  def all_items # lists all item names, both checked and unchecked, in the list
    self.list_items.where.map(&:item).map(&:name) #could combine #items and #checkoff
    ############### Can we make it so you see all unchecked items first
    # in alphabetical order, and all checked items second in alphabetical
    # order? Ideally we could differentiate the two easily, maybe just a
    # line, or possibly something as cool as squares and checks next to each?
  end

  def check_off_all
    0 #all items become still_needed: false
  end

  def need_all
    0 #all items become still_needed: true
  end

  private ###############################################################

  def item_exists(name) # accepts name, returns instance of item
    #################### if exists, returns nil if not
    Item.find_by(name: name.downcase)
  end

  def is_in_list(inst) # accepts Item INSTANCE - Returns ListItem INSTANCE
    #################### if the shopper already has one, returns nil if not
    ListItem.find_by(list_id: self.id, item_id: inst.id)
  end

  def toggle_still_needed(listitem) #changes still_needed
    if listitem.still_needed
      listitem.update(still_needed: false)
      "#{listitem.item.name.capitalize} was checked off."
    else
      listitem.update(still_needed: true)
      "#{listitem.item.name.capitalize} is on your list."
    end
  end

end
