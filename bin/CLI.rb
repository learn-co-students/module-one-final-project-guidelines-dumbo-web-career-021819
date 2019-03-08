require_relative '../config/environment'
require_relative './runner.rb'

# puts "Logging in..."
# done_in_app = nil
# grubless_session = Grubless.new
# grubless_session.create_customer
# until done_in_app == "no"
#   grubless_session.choose_restaurant
#   grubless_session.create_order
#   grubless_session.order_details
#   grubless_session.choose_food
#   grubless_session.finish_order
#   puts '------------------------------------------------------------------'
#   puts "Would you like to place another order?"
#   puts "If so hit 'enter', if not type 'no':"
#   puts '------------------------------------------------------------------'
#   done_in_app = gets.chomp
#   puts '------------------------------------------------------------------'
# end
# puts "Logging out..."


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
  puts '------------------------------------------------------------------'
  done_in_app = prompt.yes?("Would you like to place another order?")
  puts '------------------------------------------------------------------'
  puts '------------------------------------------------------------------'
end
puts "Logging out..."
