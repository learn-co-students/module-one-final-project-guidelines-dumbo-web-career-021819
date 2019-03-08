class Item < ActiveRecord::Base
  has_many :lists_items
end
