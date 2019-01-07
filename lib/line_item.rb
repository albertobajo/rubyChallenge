# @author Alberto Bajo
#
# A line item represents a single product type. There is one line item for each distinct product
# in the checkout process.
class LineItem
  attr_accessor :pricing_rule, :quantity

  # @param pricing_rule [PricingRule] to be applied.
  # @param quantity [Integer] initial amount of items.
  def initialize(pricing_rule, quantity = 0)
    @pricing_rule, @quantity = pricing_rule, quantity
  end

  # @return [Float] the final price the line item based in the pricing rule
  def total
    pricing_rule.price_for quantity
  end
end
