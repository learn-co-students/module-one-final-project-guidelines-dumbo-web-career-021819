class List < ActiveRecord::Base
  belongs_to :shopper
  has_many :lists_ingredients
end
