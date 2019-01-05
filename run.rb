#!/usr/bin/env ruby

require_relative 'checkout'

pricing_rules = [
  {"code"=>"VOUCHER", "name"=>"Cabify Voucher", "price"=>"5.00€", "discount_2for1"=>"true", "discounts_bulk_minimum_quantity"=>"0", "discounts_bulk_price"=>"0"},
  {"code"=>"TSHIRT", "name"=>"Cabify T-Shirt", "price"=>"20.00€", "discount_2for1"=>"false", "discounts_bulk_minimum_quantity"=>"3", "discounts_bulk_price"=>"19.00€"},
  {"code"=>"MUG", "name"=>"Cabify Coffee Mug", "price"=>"7.50€", "discount_2for1"=>"false", "discounts_bulk_minimum_quantity"=>"0", "discounts_bulk_price"=>"0"}
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
