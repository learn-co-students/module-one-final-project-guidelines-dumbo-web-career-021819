require 'tty-prompt'
require 'pry'
# require_relative 'item'
# require_relative 'shopper'
prompt = TTY::Prompt.new



# welcome =  prompt.select("Welcome! What would you like to do?", %w(CreateList AddToList))
# =>
# Choose your destiny? (Use arrow keys, press Enter to select)
# ‣ Scorpion
#   Kano
#   Jax

def welcome
  prompt = TTY::Prompt.new
  prompt.select("Welcome! What would you like to do?") do |option|
    option.choice 'Add to an Existing List'
    option.choice 'Create a New List'
  end
end

def welcome_choice
  prompt = TTY::Prompt.new
  if welcome == 'Add to an Existing List'
    prompt.select("Which list would you like to add to?") do |option|
      option.choice 'something soemthing'
      option.choice 'merdeeeeee'
      # Access my lists...
      end
  else
    list_name = prompt.ask("What would you like to name your list?", required: true)
    list_name = gets.chomp
    ## Pass in list_name to Shopper.create_list(list_name)
  end
end

welcome_choice


# puts "Hey"
