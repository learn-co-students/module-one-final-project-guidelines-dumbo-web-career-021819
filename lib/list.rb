class List < ActiveRecord::Base
  belongs_to :shopper
  has_many :lists_ingredients

  def add_item(item)
    #find_or_create_by
  end

  def delete_item(item)
  end

  def check_item(item)
  end

end
