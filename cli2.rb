require 'tty-prompt'
require 'pry'
require_relative 'config/environment.rb'
prompt = TTY::Prompt.new



def who_am_i
  prompt = TTY::Prompt.new
  choices = [
    {name: 'Login', value: select_name},
    {name: 'Sign Up', value: sign_up}
  ]
  prompt.select("Welcome to GroCart! Who's Here?", choices)
end

def sign_up
  prompt = TTY::Prompt.new
  prompt.ask("What is your name?", required: true)
end

@username = Shopper.create(name: sign_up)

def new_list_for_user
  prompt = TTY::Prompt.new
  new_list_name = prompt.ask("What would you like to call your list?", required: true)
  List.create(name: new_list_name, shopper_id: @username.id)
end


def select_name
  prompt = TTY::Prompt.new
  all_shoppers_names = Shopper.all.map(&:name)
  prompt.select("Select your name.", all_shoppers_names)
end

# @user_instance = Shopper.all.find_by(name: select_name)

def select_list
  prompt = TTY::Prompt.new
  userlists = @user_instance.lists.map(&:name)
  userlists << "-Add New List-"
  prompt.select("Select a list.", userlists)
end


# @list_instance = List.all.find_by(name: select_list)

def show_list
  prompt = TTY::Prompt.new
  @list_instance.items.each do |item_instance|
    puts item_instance.name
  end
  prompt.select("", %w(-options-))
end

# show_list


# username = Shopper.all[0]
# userlist = username.lists[0]


def tty_add_item_to_list
  prompt = TTY::Prompt.new
  prompt.ask("What would you like to add?", required: true)
end

def tty_delete_item_from_list
  prompt = TTY::Prompt.new
  items = Item.all.map(&:name)
  prompt.select("What would you like to delete?", items)
end

def tty_check_item_on_list
  prompt = TTY::Prompt.new
  items = Item.all.map(&:name)
  prompt.select("What item would you like to mark?", items)
end

who_am_i
p select_name

# userlist.add_item(tty_add_item_to_list)
# tty_check_item_on_list
# tty_add_item_to_list
# tty_delete_item_from_list
