class Restaurant < ActiveRecord::Base
  has_many :orders
  has_many :customers, through: :orders
  has_many :menu_items, through: :menu

end
