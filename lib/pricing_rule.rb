# @author Alberto Bajo
#
# Pricing rules for each product, including discounts to apply.
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

  # @param code [String] product identifier.
  # @param name [String] product name.
  # @param discount_bulk [Boolean] bulk discount applies if true.
  # @param discount_bulk_minimum_quantity [Integer] minimum number of products from which bulk
  #   discount is applied.
  # @param discount_bulk_price [Float] price applied if there is a bulk discount.
  # @param discount_two_for_one [Boolean] 2-for-1 discount applies if true.
  # @param price [Float] Regular price if there is no discount or number of items is less than
  #   minimum set at discount_bulk_minimum_quantity
  def initialize(code:,
                 name:,
                 discount_bulk: false,
                 discount_bulk_minimum_quantity: 0,
                 discount_bulk_price: 0.0,
                 discount_two_for_one: false,
                 price: 0.0)
    @code = code
    @name = name
    @discount_bulk = discount_bulk.to_s == 'true'
    @discount_bulk_minimum_quantity = discount_bulk_minimum_quantity.to_i
    @discount_bulk_price = discount_bulk_price.to_f
    @discount_two_for_one = discount_two_for_one.to_s == 'true'
    @price = price.to_f
  end


  # Calculates price for a given quantity of items applying pricing rule.
  #
  # @param quantity [Integer]
  # @return [Float] the final price the line item based in the pricing rule
  def calculate(quantity)
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
