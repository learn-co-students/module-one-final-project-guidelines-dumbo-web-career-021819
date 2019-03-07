class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :restaurant
  has_many :foods, through: :restaurant

  @order = []

  def grand_total
    ## error here from
    total = 0.0
    self.order.map do |food_item|
      total += food_item.price
    end
    return total
  end

  # the above order works

  def add_to_order(food_name)
    food_obj = self.foods.find_by(name: food_name)
    if @order == nil
      @order = [ food_obj ]
    else
      @order << food_obj
    end
  end

  # the above order works

  def order
    @order
  end

  def order=(order)
    @order = order
  end

  # create a method that says a customer received the order

  def receive_order
    if self.total > 0.0
      self.update(received?: true)
      return self
    end
  end

  def complete_order
    total = self.grand_total
    self.update(total: total)
    return self
  end

  def show_order
    self.order.map{ |food_obj| food_obj.name + " : #{food_obj.price}" } + ["Total : #{self.grand_total.round(2)}"]
  end

end
