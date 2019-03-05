class Customer < ActiveRecord::Base
  has_many :orders
  has_many :restaurants, through: :orders

  def pick_restaurant
    puts Restaurant.all
    answer = gets.chomp
    restaurant = Restaurant.all.find_by(name: answer)
    restaurant.show_menu
  end

  def make_order
    until answer == "done" || answer == "Done"
      answer = gets.chomp       # food that we're selecting
      if Food.all.where(name: answer) != nil
        Order.all << Food.all.where(name: answer)
      end
    end
  end


end
