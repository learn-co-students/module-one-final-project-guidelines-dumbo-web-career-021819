class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :restaurant
  has_many :foods, through: :restaurant

  @order = []

  def grand_total
    orders = self.order
    total = 0
    orders.map do |food_item|
      total += food_item.price
    end
    return total
  end

  # the above order works

  def add_to_order(food) #object
    if @order == nil
      @order = [ food ]
    else
      @order << food
    end
  end

  # the above order works

  def order
    @order
  end

  def order=(order)
    @order = order
  end


end
