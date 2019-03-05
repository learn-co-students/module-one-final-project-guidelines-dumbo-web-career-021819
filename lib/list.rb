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
    item_instance = item_exists(name)
    if item_exists(name) and is_in_list(item_instance)
      item_instance.destroy
      "Deleted '#{name.capitalize}'"
    else
      "#{name.capitalize} wasn\'t on your list."
    end
  end

  def check_item(name)
    item = item_exists(name)
    listitem = is_in_list(item)
    if item and listitem
      toggle_still_needed(listitem)
    # else @DOESNT WORK  throws error cuz listitem depends on item!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    #   "#{name.capitalize} wasn\'t on your list."
    end
    if listitem.still_needed
      "#{name.capitalize} is on your list."
    else
      "#{name.capitalize} was checked off."
    end
  end

  def items
    listitem_to_name(all_needed_listitems)
  end

  alias :all :items #You can all #items OR #all and they do the same thing
  alias :list :items

  def checked_off
    listitem_to_name(not_needed_listitems)
  end

  def all_items
    listitem_to_name(all_listitems)
  end

  private ###############################################################

  def item_exists(name)
    Item.find_by(name: name.downcase)
  end

  def is_in_list(inst)
    ListItem.find_by(list_id: self.id, item_id: inst.id)
  end

  def all_listitems
    ListItem.all.where(list_id: self.id)
  end

  def all_needed_listitems
    all_listitems.select {|item| item.still_needed}.compact #removes nil
  end

  def not_needed_listitems
    all_listitems.reject {|inst| all_needed_listitems.include?(inst)}
  end

  def listitem_to_name(array)
    get_items = array.map(&:item).compact #why is it returning nils?
    get_items.map(&:name)
  end

  def toggle_still_needed(listitem)
    if listitem.still_needed
      listitem.update(still_needed: false)
    else
      listitem.update(still_needed: true)
    end
  end

end
