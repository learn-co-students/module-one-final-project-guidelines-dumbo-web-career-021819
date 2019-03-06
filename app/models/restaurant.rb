class Restaurant < ActiveRecord::Base
  # attr_accessor :menu

  has_many :orders
  has_many :customers, through: :orders
  has_many :foods

  def show_menu
    menu = self.foods
    food_info = menu.map do |food|
      [ food.name, food.price, food.description ]
      # wierd thing about using an array is that each entry is automatically output onto a new line,
      # but you will need to edit your output so that each line is displayed as such vvvvvvv
      # Spring Roll | $4.00 | Rolled appetizer filled with roast pork, carrots, and cabbage |
    end
    return food_info
  end

  def self.all_names
    Restaurant.all.map { |restaurant| restaurant.name }
  end



end
