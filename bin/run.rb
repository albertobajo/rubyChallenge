#!/usr/bin/env ruby

require_relative '../lib/checkout'
require_relative '../lib/pricing_rule'

pricing_rules = [
  PricingRule.new(
    code: "VOUCHER",
    name: "Cabify Voucher",
    price: 5.00,
    discount_two_for_one: true,
    discount_bulk: false,
    discount_bulk_minimum_quantity: nil,
    discount_bulk_price: nil
  ),
  PricingRule.new(
    code: "TSHIRT",
    name: "Cabify T-Shirt",
    price: 20.00,
    discount_two_for_one: false,
    discount_bulk: true,
    discount_bulk_minimum_quantity: 3,
    discount_bulk_price: 19.00
  ),
  PricingRule.new(
    code: "MUG",
    name: "Cabify Coffee Mug",
    price: 7.50,
    discount_two_for_one: false,
    discount_bulk: false,
    discount_bulk_minimum_quantity: nil,
    discount_bulk_price: nil
  )
]

loop do
  begin
    co = Checkout.new(pricing_rules)

    print "Items: "
    items = gets.chomp
    items.split(',').map(&:strip).each do |item|
      co.scan(item)
    end

    puts price = co.total, ""
  rescue NoMethodError
  end
end
