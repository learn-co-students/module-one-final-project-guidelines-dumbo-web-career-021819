class List < ActiveRecord::Base
  belongs_to :shopper
  has_many :list_ingredients
end
