# @author Alberto Bajo
class PricingRule
  attr_accessor(
    :code,
    :name,
    :discount_bulk,
    :discount_bulk_minimum_quantity,
    :discount_bulk_price,
    :discount_two_for_one,
    :price
  )

  def initialize(args = {})
    args.each do |attr_name, attr_value|
      public_send("#{attr_name}=", attr_value)
    end
  end

  def price_for(quantity = 0)
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
