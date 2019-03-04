class Shopper < ActiveRecord::Base
  has_many :lists
  has_many :list_ingredients, through: :list
end
