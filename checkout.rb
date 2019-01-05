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
    line_items = Hash[@items.group_by(&:itself).map {|k,v| [k, v.size] }]
    total_price = 0.0

    line_items.each do |item_code, quantity|
      pricing_rule = @pricing_rules.detect { |o| o["code"] === item_code }

      if pricing_rule["discount_2for1"] === "true"
        # REVIEW: change this name
        price = pricing_rule["price"].gsub(/[^\d\.]/, '').to_f
        cobrable_items = (quantity.to_f / 2).ceil
        total_price += cobrable_items * price
      elsif pricing_rule["discounts_bulk_minimum_quantity"] > "0" and quantity >= pricing_rule["discounts_bulk_minimum_quantity"].to_i
        price = pricing_rule["discounts_bulk_price"].gsub(/[^\d\.]/, '').to_f
        total_price += quantity * price
      else
        price = pricing_rule["price"].gsub(/[^\d\.]/, '').to_f
        total_price += quantity * price
      end
    end

    return "#{sprintf('%.2f', total_price)}€"
  end
end
