require 'cabify_store/pricing_line'

# @author Alberto Bajo
#
# Stores scanned items and calculates total price of checkout processes in the Cabify's physical
# store.
class Checkout
  # Returns a new instance of Checkout and initializes a hash of PricingLine objects
  #
  # @param pricing_rules [Array<PricingRule>] the list of pricing rules that must be used for
  #   calculate total price.
  def initialize(pricing_rules)
    @pricing_lines = {}
    pricing_rules.each { |rule| @pricing_lines[rule.code] = PricingLine.new(rule) }
  end

  # Adds an item to the correspond price line.
  #
  # @param code [String] Item code.
  def scan(code)
    @pricing_lines[code].quantity += 1
  end

  # Calculates the final price of the scanned items based in the initial pricing rules.
  #
  # @return [String] Total price in Euros.
  def total
    "%.2f€" % @pricing_lines.values.sum(&:total)
  end
end
