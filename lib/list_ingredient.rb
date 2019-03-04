class ListIngredient < ActiveRecord::Base
  belongs_to :list
  belongs_to :ingredient
end
