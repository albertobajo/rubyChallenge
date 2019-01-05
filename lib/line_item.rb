class LineItem
  attr_accessor :code
  attr_accessor :discount_bulk
  attr_accessor :discount_bulk_minimum_quantity
  attr_accessor :discount_bulk_price
  attr_accessor :discount_two_for_one
  attr_accessor :price
  attr_accessor :quantity

  def total_price
    final_price = nil

    raise TypeError unless price.is_a? Float
    raise TypeError unless discount_bulk_price.nil? or discount_bulk_price.is_a? Float

    if discount_two_for_one
      final_quantity = (quantity.to_f / 2).ceil
      final_price = final_quantity * price
    elsif discount_bulk and quantity >= discount_bulk_minimum_quantity
      final_price = quantity * discount_bulk_price
    else
      final_price = quantity * price
    end

    return final_price
  end

  # def initialize()
  # end
end
