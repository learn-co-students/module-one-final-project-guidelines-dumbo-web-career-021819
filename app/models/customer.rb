class Customer < ActiveRecord::Base
  has_many :orders
  has_many :restaurants, through: :orders

  # def past_orders
  #  past_orders = Order.all.where(customer_id: self.id).where("total > '0.0'").order(id: :asc)

    # past_orders_clean = past_orders.map{ |order_obj| order_obj.show_order }

  # end

end
