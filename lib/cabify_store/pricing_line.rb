# @author Alberto Bajo
#
# PricingRule decorator, adds quantity attribute and total method. Represents a single
# line in the shopping cart.
class PricingLine < SimpleDelegator
  attr_accessor :quantity

  # @param pricing_rule [PricingRule].
  # @param quantity [Integer] initial amount of items.
  def initialize(pricing_rule, quantity = 0)
    super(pricing_rule)

    @quantity = quantity
  end

  # Calculates the total line item price for quantity.
  # @return [Float] the final price the line item based in the pricing rule
  def total
    calculate(quantity)
  end
end
