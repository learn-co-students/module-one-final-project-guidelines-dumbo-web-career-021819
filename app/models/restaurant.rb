class Restaurant < ActiveRecord::Base
  # attr_accessor :menu

  has_many :orders
  has_many :customers, through: :orders
  has_many :foods

  def show_menu
    Food.all.where(restaurant_id: self.id)
  end

end
