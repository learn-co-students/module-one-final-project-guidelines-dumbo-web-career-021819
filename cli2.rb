require 'tty-prompt'
require 'pry'

#The below is causing welcome to loop twice
require_relative 'config/environment.rb'
prompt = TTY::Prompt.new

def who_am_i
  prompt = TTY::Prompt.new
  puts List.all[1].name
  prompt.select("Welcome to GroCart! Who's Here?", %w(Login New_User))
end
def flow
  who_am_i
  if who_am_i == 'Login'
    puts 'Heyyyyyy againnn'
  else
    puts 'Fresh meat!'
  end
end

flow
