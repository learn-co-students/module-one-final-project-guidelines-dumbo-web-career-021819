class Ingredient < ActiveRecord::Base
  has_many :lists_ingredients
end
