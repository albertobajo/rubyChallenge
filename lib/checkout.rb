# @author Alberto Bajo

require_relative('line_item')

class Checkout
  # @param pricing_rules [Array<PricingRule>] the list of pricing rules that must be used for
  #   calculate total price.
  def initialize(pricing_rules)
    @line_items = {}
    pricing_rules.each { |rule| @line_items[rule.code] = LineItem.new(rule) }
  end

  # Adds an item to the checkout process
  #
  # @param code [String] Item code.
  def scan(code)
    @line_items[code].quantity += 1
  end

  # Calculates the final price of the scanned items based in the pricing rules.
  #
  # @return [String] Total price in Euros.
  def total
    "%.2f€" % @line_items.values.sum(&:total)
  end
end
