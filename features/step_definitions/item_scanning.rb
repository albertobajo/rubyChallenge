Given("the following pricing rules") do |table|
  @co = Checkout.new(table.hashes)
end

When("{string} is scanned") do |item_code|
  @co.scan(item_code)
end

Then("total price should be {string}") do |total_price|
  expect(@co.total).to eq(total_price)
end
