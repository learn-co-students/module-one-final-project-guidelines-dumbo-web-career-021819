require 'tty-prompt'
require 'pry'
require_relative 'config/environment.rb'
prompt = TTY::Prompt.new

#
def who_am_i
  prompt = TTY::Prompt.new
  options = ["Login", "New User"]
  prompt.select("Welcome to GroCart! Who's Here?", options)
end

def sign_up
  prompt = TTY::Prompt.new
  prompt.ask("What is your name?", required: true)
end

@username = sign_up

def new_list_for_user
  new_list = List.create
end


#
# def flow
#
#   if who_am_i == 'Login'
#     puts 'Heyyyyyy againnn'
#   else
#     puts 'Fresh meat!'
#   end
# end
#
# flow

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


# userlist.add_item(tty_add_item_to_list)
# tty_check_item_on_list
# tty_add_item_to_list
# tty_delete_item_from_list
