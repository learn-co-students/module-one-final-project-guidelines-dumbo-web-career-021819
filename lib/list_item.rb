class ListItem < ActiveRecord::Base
  belongs_to :list
  belongs_to :item

  def initialize(one)
    super
    self.still_needed = true
  end
end
