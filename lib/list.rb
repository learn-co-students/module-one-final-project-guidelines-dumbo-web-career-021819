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
      item_instance.destroy
      "Deleted '#{name.capitalize}'"
    else ############DELETES ITEM, NOT LISTITEM!!!
      "#{name.capitalize} wasn\'t on your list."
    end
  end

  def check_item(name) # changes the item's still_needed boolean
    item = item_exists(name)
    if item
      listitem = is_in_list(item)
      if listitem
        return toggle_still_needed(listitem)
      end
    end
    "#{name.capitalize} wasn't on your list."
  end

  def items #lists all item names that are NOT checked in the list)
    listitem_to_name(all_needed_listitems)
  end

  alias :all :items #You can all #items OR #all and they do the same thing
  alias :list :items

  def checked_off # lists all item names that ARE checked in the list.
    listitem_to_name(not_needed_listitems)
  end

  def all_items # lists all item names, both checked and unchecked, in the list
    listitem_to_name(all_listitems)
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

  def all_listitems # finds all ListItem INSTANCES with the list's ID.
    ListItem.all.where(list_id: self.id)
  end

  def all_needed_listitems # same as all_listitems ^, only returns if UNCHECKED (still_needed: true)
    all_listitems.select {|item| item.still_needed}.compact #removes nil
  end

  def not_needed_listitems # same as all_listitems ^^, only returns if CHECKED (still_needed: false)
    all_listitems.reject {|inst| all_needed_listitems.include?(inst)}
  end

  def listitem_to_name(array) #Takes array of ListItems and returns array of Item names
    get_items = array.map(&:item).compact #why is it returning nils?
    get_items.map(&:name)
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
