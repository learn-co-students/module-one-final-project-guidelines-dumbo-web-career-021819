class Ingredient < ActiveRecord::Base
  has_many :list_items
  belongs_to :list, through: :list_items
end
