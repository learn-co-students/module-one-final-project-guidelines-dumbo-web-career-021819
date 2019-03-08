class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :restaurant
  has_many :foods, through: :restaurant

  def order
    @order
  end

  def order=(order)
    @order = order
  end

  def show_order
    @order.map { |food_obj| food_obj.name + " : #{food_obj.price}" } + ["Total : #{grand_total.round(2)}"]
  end

  def complete_order
    total = grand_total
    update(total: total)
  end

  def add_to_order(food_name)
    food_obj = foods.find_by(name: food_name)
    if @order.nil?
      @order = [food_obj]
    else
      @order << food_obj
    end
  end

  def delete_food(food_name)
    food_obj = Food.find_by(name: food_name)
    if order.include?(food_obj)
      order.delete_at(order.index(food_obj))
    end
    order
  end

  def grand_total
    total = 0.0
    order.map do |food_item|
      total += food_item.price
    end
    total
  end
end
