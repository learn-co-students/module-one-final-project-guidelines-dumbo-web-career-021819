require 'tty-prompt'
require 'pry'

#The below is causing welcome to loop twice
require_relative 'config/environment.rb'
prompt = TTY::Prompt.new

def who_am_i
  prompt = TTY::Prompt.new
  prompt.select("Welcome to GroCart! Who's Here?", %w(Login New_User))
end

def flow
  if who_am_i == 'Login'
    login
  else
    puts 'Fresh meat!'
  end
end

def login
  prompt = TTY::Prompt.new
  shoppers = Shopper.all.map(&:name)
  prompt.select("Welcome to GroCart! Who's Here?", shoppers)
end

flow
