Given("the following pricing rules") do |table|
  pricing_rules = table.hashes.map do |rule|
    PricingRule.new(
      code: rule["code"],
      name: rule["name"],
      discount_bulk: rule["discount_bulk"].to_s == 'true',
      discount_bulk_minimum_quantity: rule["discount_bulk_minimum_quantity"].to_i,
      discount_bulk_price: rule["discount_bulk_price"].to_f,
      discount_two_for_one: rule["discount_two_for_one"].to_s == 'true',
      price: rule["price"].to_f
    )
  end

  @co = Checkout.new(pricing_rules)
end

When("{string} is scanned") do |item_code|
  @co.scan(item_code)
end

Then("total price should be {string}") do |total_price|
  expect(@co.total).to eq(total_price)
end
