class Restaurant < ActiveRecord::Base
  # attr_accessor :menu

  has_many :orders
  has_many :customers, through: :orders
  has_many :foods

  def show_menu
    foods.map do |food|
      "#{food.name} | #{food.price} | #{food.description}"
    end
  end

  def self.all_names
    Restaurant.all.map(&:name).uniq
  end
end
