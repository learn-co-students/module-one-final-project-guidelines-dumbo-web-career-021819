class Restaurant < ActiveRecord::Base
  # attr_accessor :menu

  has_many :orders
  has_many :customers, through: :orders
  has_many :foods

  def show_menu
    menu = self.foods
    food_info = menu.map do |food|
      { "name" => food.name, "description" =>  food.description, "price" => food.price }
    end
    return food_info
  end

  def self.all_names
    Restaurant.all.map { |restaurant| restaurant.name }
  end




end
