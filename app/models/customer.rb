class Customer < ActiveRecord::Base
  has_many :orders
  has_many :restaurants, through: :orders

  def past_orders
    Order.all.where(customer_id: self.id).where(received?: true).order(id: :asc)
  end

end
