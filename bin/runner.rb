require_relative '../config/environment.rb'
require_relative './CLI.rb'

system "clear" or system "cls"
puts "Logging in..."
prompt = TTY::Prompt.new
done_in_app = nil
grubless_sesh = TtyGrubless.new
grubless_sesh.create_customer
until done_in_app == false
  grubless_sesh.choose_restaurant
  grubless_sesh.create_order
  grubless_sesh.order_details
  grubless_sesh.choose_food
  grubless_sesh.finish_order
  done_in_app = prompt.yes?("Would you like to place another order?")
  puts '------------------------------------------------------------------'
  system "clear" or system "cls"
end
puts "Logging out..."
