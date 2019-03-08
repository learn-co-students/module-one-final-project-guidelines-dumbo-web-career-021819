require_relative '../config/environment'

# prompt = TTY::Prompt.new
class Grubless
  attr_accessor :customer, :order, :restaurant

  def initialize
    @customer = nil
    @order = nil
    @restaurant = nil
  end

  def create_customer
    puts '------------------------------------------------------------------'
    puts 'Welcome to Grubless !'
    puts "What's your name ?"
    puts '------------------------------------------------------------------'
    customer_name = gets.chomp
    puts '------------------------------------------------------------------'
    @customer = if Customer.find_by(name: customer_name).nil?
                 Customer.create(name: customer_name)
               else
                 Customer.find_by(name: customer_name)
               end
    puts "Thanks for choosing Grubless #{customer_name} !"
    puts '------------------------------------------------------------------'
  end

  def choose_restaurant
    restaurant_name = nil
    until Restaurant.find_by(name: restaurant_name).is_a?(Restaurant) == true
      puts 'Choose a restaurant from the following list:'
      puts Restaurant.all_names
      puts '------------------------------------------------------------------'
      restaurant_name = gets.chomp
      puts '------------------------------------------------------------------'
      if Restaurant.find_by(name: restaurant_name) != nil
        @restaurant = Restaurant.find_by(name: restaurant_name)
      else
        puts "Sorry, we don't work with that restaurant currently.."
        puts '------------------------------------------------------------------'
        restaurant_name = nil
      end
    end
    puts 'Great choice !'
    puts '------------------------------------------------------------------'
  end

  def create_order
    @order = Order.create(customer_id: @customer.id, restaurant_id: @restaurant.id)
  end

  def order_details
    customer_order = @order
    restaurant = @restaurant
    d_or_t = nil
    until d_or_t == 'delivery' || d_or_t == 'takeout'
      puts 'How would you like to receive your order?'
      puts "Enter 'delivery' or 'takeout':"
      d_or_t = gets.chomp.downcase
      puts '------------------------------------------------------------------'
      set_d_or_t = customer_order.update(delivery_or_takeout: d_or_t)
      if d_or_t == 'delivery'
        set_d_or_t
        puts 'Where should we deliver your food?'
        puts '------------------------------------------------------------------'
        order_address = gets.chomp
        puts '------------------------------------------------------------------'
        customer_order.update(location: order_address)
      elsif d_or_t == 'takeout'
        set_d_or_t
        customer_order.update(location: restaurant.location)
      else
        puts "That method of receiving an order isn't availble yet.."
        puts '------------------------------------------------------------------'
        d_or_t = nil
      end
    end

    payment_method = nil
    until payment_method == 'cash' || payment_method == 'card'
      puts 'How will you pay for your order?'
      puts "Enter 'cash' or 'card' :"
      puts '------------------------------------------------------------------'
      payment_method = gets.chomp.downcase
      puts '------------------------------------------------------------------'
      if payment_method == 'cash' || payment_method == 'card'
        customer_order.update(cash_or_card: payment_method)
      else
        puts "Sorry, but you can't pay us in that!"
        puts '------------------------------------------------------------------'
        payment_method = nil
      end
    end
  end

  def choose_food
    customer_order = @order
    restaurant = @restaurant
    formatted_menu = restaurant.show_menu
    puts "Here's the menu for this restaurant:"

    food_choice = nil
    until food_choice == 'done'
      puts formatted_menu
      puts '------------------------------------------------------------------'
      puts "What would you like to add to your order? (if nothing else type 'done')"
      puts 'Type in the name of the food exactly as it appears in the menu:'
      puts "If you would like to delete an item from your order type 'delete,<food>':"
      puts '------------------------------------------------------------------'
      food_choice = gets.chomp
      puts '------------------------------------------------------------------'
      delete_food_item = food_choice.split(',')
      delete_food_item = delete_food_item[1]

      # elsif food_choice == "delete,#{delete_food_item}" &&
      #   Restaurant.find_by(name: restaurant_name).foods.find_by(name: delete_food_item) != nil &&
      #   customer_order.order.include?(Food.find_by(name: delete_food_item))
      #   # Set a condition that if a food isn't on your menu, puts "That item is not in your order"
      #   customer_order.delete_food(delete_food_item)
      # end
      if food_choice == 'done' || food_choice == 'Done'
        # when we type in done, Order.order is set equal to an empty array
        break
      elsif food_choice == "delete,#{delete_food_item}" &&
        Restaurant.find_by(name: restaurant.name).foods.find_by(name: delete_food_item) != nil
        customer_order.delete_food(delete_food_item)
        puts customer_order.show_order
        puts '------------------------------------------------------------------'
        puts "You've deleted '#{delete_food_item}' from your order."
        puts '------------------------------------------------------------------'
      elsif food_choice == "delete,#{delete_food_item}" &&
        Restaurant.find_by(name: restaurant.name).foods.find_by(name: delete_food_item) == nil
        puts "'#{delete_food_item}' isn't in your order."
        puts '------------------------------------------------------------------'
      elsif Restaurant.find_by(name: restaurant.name).foods.map(&:name).include?(food_choice)
        customer_order.add_to_order(food_choice)
        puts customer_order.show_order
        puts '------------------------------------------------------------------'
      else
        puts customer_order.show_order
        puts '------------------------------------------------------------------'
        puts "'#{food_choice}' is not on the menu. Please type in a dish from the menu:"
        puts '------------------------------------------------------------------'
      end
    end
  end

  def finish_order
    customer_order = @order
    customer = @customer
    customer_order.complete_order
    puts customer_order.show_order
    puts '------------------------------------------------------------------'
    puts "Thank you for ordering from Grubless #{customer.name}! Your order will be there ASAP!"
  end
end
