require_relative '../config/environment'
ActiveRecord::Base.logger = nil
# prompt = TTY::Prompt.new

  # GET CUSTOMER NAME
  puts "------------------------------------------------------------------"
  puts "Welcome to Grubless !"
  puts "What's your name ?"
  puts "------------------------------------------------------------------"
  customer_name = gets.chomp
  puts "------------------------------------------------------------------"
  if Customer.find_by(name: customer_name) == nil
    customer = Customer.create(name: customer_name)
  else
    customer = Customer.find_by(name: customer_name)
  end
    # puts "Would you like to see your past orders? If so, type 'yes' else press Enter."
    # history_input = gets.chomp.downcase
    # if history_input == "yes"

      # Take user input, ask for which item in the array. Subtract input by 1 b/c of mismatch indexes
      # then choose which order they would like to reorder. Refer to past_orders array[history_input]
      # Make a new instance but with the same items.
    # end

  # CUSTOMER CHOOSES RESTAURANT

  puts "Thanks for choosing Grubless #{customer_name} !"
  puts "------------------------------------------------------------------"
  # puts "Restaurant List:"
  # puts Restaurant.all_names
  # puts "What restaurant would you like to choose?"
  restaurant_name = nil
  until Restaurant.find_by(name: restaurant_name).is_a?(Restaurant) == true
    puts "Choose a restaurant from the following list:"
    puts Restaurant.all_names
    puts "------------------------------------------------------------------"
    restaurant_name = gets.chomp
    puts "------------------------------------------------------------------"
    if Restaurant.find_by(name: restaurant_name) != nil
      restaurant = Restaurant.find_by( name: restaurant_name )
      customer_order = Order.create( customer_id: customer.id, restaurant_id: restaurant.id )
    else
      puts "Sorry, we don't work with that restaurant currently.."
      puts "------------------------------------------------------------------"
    end
  end
  puts "Great choice !"
  puts "------------------------------------------------------------------"


  # CUSTOMER CHOOSES DELIVERY OR TAKEOUT & CHOOSES DELIVERY LOCATION

  d_or_t = nil
  until d_or_t == "delivery" || d_or_t == "takeout"
    puts "How would you like to receive your order?"
    puts "Enter 'delivery' or 'takeout' :"
    puts "------------------------------------------------------------------"
    d_or_t = gets.chomp.downcase
    puts "------------------------------------------------------------------"
    if d_or_t == "delivery"
      puts "Where should we deliver your food?"
      puts "------------------------------------------------------------------"
      order_address = gets.chomp
      puts "------------------------------------------------------------------"
      customer_order.update(delivery_or_takeout: d_or_t)
      customer_order.update(location: order_address)
    elsif d_or_t == "takeout"
      customer_order.update(delivery_or_takeout: d_or_t)
      customer_order.update(location: restaurant.location )
    else
      puts "That method of receiving an order isn't availble yet.."
    end
  end

  # CUSTOMER CHOOSES WHETHER THEY WANT TO PAY WITH CASH OR CARD

  payment_method = nil
  until payment_method == "cash" || payment_method == "card"
    puts "How will you pay for your order?"
    puts "Enter 'cash' or 'card' :"
    puts "------------------------------------------------------------------"
    payment_method = gets.chomp.downcase
    puts "------------------------------------------------------------------"

    if payment_method == "cash" || payment_method == "card"
      customer_order.update(cash_or_card: payment_method)

    # elsif payment_method == "card"
    #   customer_order.update(cash_or_card: "card")
    else
      puts "You can't pay us in that!"
      puts "------------------------------------------------------------------"
    end
  end

  # ADD ITEMS TO THE ORDER
  # * can only use Order#complete_order once you have used Order#add_to_order
  # * can only use Order#receive_order once you have used Order#complete_order


  order_done = ""
  puts "Here's the menu for this restaurant:"

  until order_done == "done"
    formatted_menu = restaurant.show_menu.map do |food_item|
      puts "#{food_item[0]} | #{food_item[1]} | #{food_item[2]}"
    end
    puts "------------------------------------------------------------------"
    puts "What would you like to add to your order? (if nothing else type 'done')"
    puts "Type in the name of the food exactly as it appears in the menu:"
    puts "If you would like to delete an item from your order type 'delete,<food>':"
    puts "------------------------------------------------------------------"
    # allows us to enter foods that are not on the menu
    food_choice = gets.chomp
    puts "------------------------------------------------------------------"

    delete_food_item = food_choice.split(",")
    delete_food_item = delete_food_item[1]

    # if food_choice == 'done' || food_choice == 'Done'
    #   break
    # elsif food_choice == "delete,#{delete_food_item}" && Restaurant.find_by(name: restaurant_name).foods.find_by(name: delete_food_item) != nil
    #   customer_order.delete_food(delete_food_item)
    # end

    if Restaurant.find_by(name: restaurant_name).foods.map{|food| food.name}.include?(food_choice)
      customer_order.add_to_order(food_choice)

      puts customer_order.show_order
      puts "------------------------------------------------------------------"
      # Healthy Heart Salad : 8.95
      # Healthy Heart Salad : 8.95
      # Tri-Color Salad : 8.95 BUG HERE , THE TOTAL IS LONG NUM

    elsif food_choice == "delete,#{delete_food_item}" && Restaurant.find_by(name: restaurant_name).foods.find_by(name: delete_food_item) != nil
      
      puts customer_order.show_order
      puts "------------------------------------------------------------------"
      puts "You've delete #{delete_food_item} from your order."
      puts "------------------------------------------------------------------"
    elsif food_choice == 'done' || food_choice == 'Done'
      break
    else
      puts customer_order.show_order
      formatted_menu
      puts "That dish is not on the menu. Please type in a dish from the menu:"
      puts "------------------------------------------------------------------"
    end
  end

  # the second time you enter a food, the order is not shown

  # also the second time you enter a food, it doesn't ask if you're done with your order.

  # order isn't shown after you type done when selecting from resauraunt menu


  customer_order.complete_order

  puts customer_order.show_order
  puts "------------------------------------------------------------------"
  puts "Thank you for ordering from Grubless! Your order will be there ASAP!"
  puts "------------------------------------------------------------------"

  # Fulfill user story for viewing past orders.










#-------------------------------------------------------------------------------
  # everything works and the total attribute for the Order is updated


  # After we complete a customer's order, what should we do??
  # In order to refer to past orders, we need to use Order#receive_order
  # We need to be able to ask the user if they have received their order yet.

  # ^^^ HARD IMPLEMENTATION : allow a user to refer to a past order that they haven't
  # received and notify the company that they've received that order. ^^

  # EASY IMPLEMENTATION : Keep the console on the have you received your order yet
  # prompt until they enter yes, which will change the value to true and add the order
  # to past orders.

  # EASY BETTER IMPLEMENTATION : Do not require Order#past_orders to require that
  # an order is received, but rather set a condition that says if the order total
  # is > 0.0 , then push that order into the past_orders array (customer's past orders).
#-------------------------------------------------------------------------------
