class Shopper < ActiveRecord::Base
  has_many :lists
  has_many :lists_ingredients, through: :list
end
