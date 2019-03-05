class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :restaurant
  has_many :foods, through: :restaurant

  @@order = []

  def grand_total
    # we need to be able to add MenuItems to order first
    # in order to sum the total of all MenuItems within
    # order
  end

  def add_to_order(food) #object
    @@order << food
  end

  def self.order
    @@order
  end





end
