class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :restaurant
  has_many :foods, through: :restaurant

  @order = []

  def grand_total
    orders = self.order
    total = 0.0
    orders.map do |food_item|
      total += food_item.price
    end
    self.update(total: total)
    return self
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

  # create a method that says a customer received the order

  def receive_order
    if self.total > 0.0
      self.update(received?: true)
      return self
    end
  end

  def complete_order
    return self.grand_total
  end

  def show_order
    self.order.map{ |food_obj| food_obj.name + " : #{food_obj.price}" } + ["Total : #{Order.find(self.id).total}"]
  end

end
