require_relative '../config/environment'
require_relative './runner.rb'

puts "Logging in..."
done_in_app = nil
grubless_session = Grubless.new
grubless_session.create_customer
until done_in_app == "no"
  grubless_session.choose_restaurant
  grubless_session.create_order
  grubless_session.order_details
  grubless_session.choose_food
  grubless_session.finish_order
  puts '------------------------------------------------------------------'
  puts "Would you like to place another order?"
  puts "If so hit 'enter', if not type 'no':"
  puts '------------------------------------------------------------------'
  done_in_app = gets.chomp
  puts '------------------------------------------------------------------'
end
puts "Logging out..."
