require_relative '../config/environment'

# Without TTYPrompt Section

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

      if food_choice == 'done' || food_choice == 'Done'
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


# TTY Prompt section

# grubless_sesh.create_customer
# grubless_sesh.choose_restaurant
# grubless_sesh.create_order
# grubless_sesh.order_details
# grubless_sesh.choose_food
# grubless_sesh.finish_order


class TtyGrubless
  attr_accessor :customer, :order, :restaurant, :prompt


  def initialize
    @customer = nil
    @order = nil
    @restaurant = nil
    @prompt = TTY::Prompt.new
  end

  def create_customer
    customer_name = prompt.ask("Welcome to Grubless! What's your name?") do |q|
                      q.required true
                      q.modify :capitalize
                      q.convert -> (input) { input.to_s }
                    end
    @customer = if Customer.find_by(name: customer_name).nil?
                  Customer.create(name: customer_name)
                else
                  Customer.find_by(name: customer_name)
                end
    system "clear" or system "cls"
    puts '------------------------------------------------------------------'
    puts "Thanks for choosing Grubless #{customer_name}!"
    puts '------------------------------------------------------------------'
  end

  def choose_restaurant
    restaurants = Restaurant.all_names
    restaurant_name = prompt.enum_select('Choose a restaurant from the following list:', restaurants)
    @restaurant = Restaurant.find_by(name: restaurant_name)
    system "clear" or system "cls"
    puts '------------------------------------------------------------------'
    puts 'Great choice!'
    puts '------------------------------------------------------------------'

  end

  def create_order
    @order = Order.create(customer_id: @customer.id, restaurant_id: @restaurant.id)
  end

  def order_details
    d_or_t_opts = %w(delivery takeout)
    @order.delivery_or_takeout = prompt.enum_select('How would you like to receive your order?', d_or_t_opts)
    if @order.delivery_or_takeout == 'delivery'
      system "clear" or system "cls"
      @order.location = prompt.ask("Where would you like your order delivered?") do |q|
                          q.required true
                          q.convert -> (location) { location.to_s }
                        end
    else
      @order.location = @restaurant.location
    end
    puts '------------------------------------------------------------------'
    system "clear" or system "cls"

    @order.cash_or_card = prompt.enum_select('How will you pay for your order?', ["cash", "card"])
    puts '------------------------------------------------------------------'
    system "clear" or system "cls"
    if @order.cash_or_card == "card"
      card_info = prompt.collect do
        key(:name).ask("Enter the cardholder's name:")
        system "clear" or system "cls"
        key(:card_number).ask('Enter card number (XXXX-XXXX-XXXX-XXXX):') do |card_num|
          card_num.validate(/\A\d{4}\-\d{4}\-\d{4}\-\d{4}\Z/, 'Incorrect card number format')
        end
        system "clear" or system "cls"
        key(:expiration_date).ask("Enter expiration date (XX-XX):") do |exp_date|
          exp_date.validate(/\A\d{2}\-\d{2}\Z/, 'Invalid expiration date')
        end
        system "clear" or system "cls"
        key(:cvv).ask("Enter CVV number (XXX):") do |cvv|
          cvv.validate(/\A\d{3}\Z/, 'Not a valid CVV')
        end
        system "clear" or system "cls"
      end
      puts '------------------------------------------------------------------'
      puts "Cardholder Name: #{card_info[:name]}"
      puts "Card Number: #{card_info[:card_number]}"
      puts "Expiration Date: #{card_info[:expiration_date]}"
      puts "CVV: #{card_info[:cvv]}"
      puts '------------------------------------------------------------------'
      system "clear" or system "cls"
    end
  end

  def choose_food
    finished =  nil
    until finished == true
      system "clear" or system "cls"
      menu = @restaurant.show_menu
      food_choice = prompt.enum_select('What would you like to add to your order?', menu)
      food_name = food_choice.split(' | ')[0]
      food = @restaurant.foods.find_by(name: food_name)
      @order.add_to_order(food_name)
      system "clear" or system "cls"
      puts '------------------------------------------------------------------'
      puts @order.show_order
      puts '------------------------------------------------------------------'
      delete_q = prompt.yes?('Would you like to delete any items from your order?')
      system "clear" or system "cls"
      done_delete = false
      if delete_q == true

        until done_delete == true
          show_order = @order.order.map{|food| food.name }
          delete_item = prompt.enum_select('What item would you like to remove from your order?', show_order)
          system "clear" or system "cls"
          puts '------------------------------------------------------------------'
          @order.delete_food(delete_item)
          puts @order.show_order
          puts '------------------------------------------------------------------'
          done_delete = prompt.yes?('Are you done deleting items from your order?')
          system "clear" or system "cls"
        end
      end
      # system "clear" or system "cls"
      puts '------------------------------------------------------------------'
      finished = prompt.yes?("Are you finished ordering?")
      puts '------------------------------------------------------------------'
    end
    system "clear" or system "cls"
  end

  def finish_order
    system "clear" or system "cls"
    @order.complete_order
    puts '------------------------------------------------------------------'
    puts @order.show_order
    puts '------------------------------------------------------------------'
    puts "Thank you for ordering from Grubless #{customer.name}! Your order will be there ASAP!"
    puts '------------------------------------------------------------------'
  end
end
