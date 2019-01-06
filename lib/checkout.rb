require_relative 'line_item'

class Checkout
  def initialize(pricing_rules)
    @line_items = Hash.new

    pricing_rules.each do |rule|
      li = LineItem.new
      li.code = rule["code"]
      li.quantity = 0
      li.price = rule["price"].gsub(/[^\d\.]/, '').to_f
      li.discount_bulk = rule["discount_bulk"] === "true"
      li.discount_bulk_price = rule["discount_bulk_price"].gsub(/[^\d\.]/, '').to_f
      li.discount_bulk_minimum_quantity = rule["discount_bulk_minimum_quantity"].to_i
      li.discount_two_for_one = rule["discount_2for1"] === "true"

      @line_items[li.code] = li
    end
  end

  def scan(code)
    @line_items[code].quantity += 1
  end

  def total
    "%.2f€" % @line_items.values.sum(&:total_price)
  end
end
