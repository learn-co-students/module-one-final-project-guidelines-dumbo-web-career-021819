require_relative '../config/environment'

class Runner
  puts "Hello! Welcome to Grubless"
  puts "What is your name?"
  customer_name = gets.chomp
  Customer.create(name: customer_name)


  puts "Thanks for choosing Grubless, #{customer_name}"
  puts "What restaurant would you like to choose?"
  puts Restaurant.all_names
  restaurant_name = gets.chomp
  customer_order = Order.create(customer_id: Customer.find_by(name: customer_name).id, restaurant_id: Restaurant.find_by(name: restaurant_name).id)
  puts "Would you like a 'delivery' or 'pick up'?"
  obtain_food = gets.chomp.downcase
  until obtain_food == "delivery" || obtain_food == "pick up"
    # didn't ask for our location
    if obtain_food == "delivery"
      puts "Where would you like the food to be delivered?"
      order_address = gets.chomp
      customer_order.update(deliver_or_pickup: "delivery")
      customer_order.update(location: order_address)
    elsif obtain_food == "pick up"
      customer_order.update(deliver_or_pickup: "pick up")
    else
      puts "Please enter a valid response"
      obtain_food = gets.chomp
    end
  end

  puts "Would you like to pay with cash or card?"
  payment_method = gets.chomp.downcase
  until payment_method == "cash" || payment_method == "card"
    if payment_method == "cash"
      customer_order.update(cash_or_card: "cash")
    elsif payment_method == "card"
      customer_order.update(cash_or_card: "card")
    else
      puts "Please select cash or card"
      payment_method = gets.chomp
    end
  end


  # not good
  puts "Great choice!"
  order_done = ""
  until order_done == "done"
    # doesn't work
    formatted_menu = Restaurant.find_by(name: restaurant_name).show_menu.map do |food_item|
      puts "#{food_item[0]} | #{food_item[1]} | #{food_item[2]}"
    end
    puts "What would you like to order?"
    # allows us to enter foods that are not on the menu
    food_choice = gets.chomp
    if Restaurant.find_by(name: "Andiamo").foods.map{|food| food.name}.include?(food_choice)
      customer_order.add_to_order(food_choice)
      puts "Would you like to order more? If not, type 'done'"
      order_done = gets.chomp
    else
      formatted_menu
      puts "That dish is not on the menu. Please type in a dish from the menu:"
      food_choice = gets.chomp
    end
  end

end








# ------------------------------------------------------------------------------
# WHEN USING Restaurant#show_menu (AFTER A USER SELECTS A RESTAURANT)
# ------------------------------------------------------------------------------
# wierd thing about using an array is that each entry is automatically output onto a new line,
# but you will need to edit your output so that each line is displayed as such vvvvvvv
# Spring Roll | $4.00 | Rolled appetizer filled with roast pork, carrots, and cabbage |
# ------------------------------------------------------------------------------
