require_relative 'line_item'

class Checkout
  attr_accessor :pricing_rules
  attr_reader :items

  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @items = []
  end

  def scan(item_code)
    @items << item_code
  end

  def total
    items = Hash[@items.group_by(&:itself).map {|k,v| [k, v.size] }]
    total_price = 0.0

    items.each do |item_code, quantity|
      li = LineItem.new
      pricing_rule = @pricing_rules.detect { |o| o["code"] === item_code }

      li.code = item_code
      li.quantity = quantity
      li.price = pricing_rule["price"].gsub(/[^\d\.]/, '').to_f
      li.discount_bulk = pricing_rule["discount_bulk"] === "true"
      li.discount_bulk_price = pricing_rule["discount_bulk_price"].gsub(/[^\d\.]/, '').to_f
      li.discount_bulk_minimum_quantity = pricing_rule["discount_bulk_minimum_quantity"].to_i
      li.discount_two_for_one = pricing_rule["discount_2for1"] === "true"

      total_price += li.total_price
    end

    return "#{sprintf('%.2f', total_price)}€"
  end
end
