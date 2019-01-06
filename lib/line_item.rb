class LineItem
  attr_accessor :code
  attr_accessor :discount_bulk
  attr_accessor :discount_bulk_minimum_quantity
  attr_accessor :discount_bulk_price
  attr_accessor :discount_two_for_one
  attr_accessor :price
  attr_accessor :quantity

  def total_price
    raise TypeError unless price.is_a? Float
    raise TypeError unless
      discount_bulk_price.nil? or discount_bulk_price.is_a? Float

    if discount_two_for_one
      chargeable_items = (quantity.to_f / 2).ceil
      chargeable_items * price
    elsif discount_bulk and quantity >= discount_bulk_minimum_quantity
      quantity * discount_bulk_price
    else
      quantity * price
    end
  end
end
