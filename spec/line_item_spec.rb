require_relative '../lib/pricing_rule'
require_relative '../lib/line_item'

describe LineItem do
  before(:each) do
    @pricing_rule = PricingRule.new(
      code: "VOUCHER",
      name: "Cabify Voucher",
      price: 5.00,
      discount_two_for_one: false,
      discount_bulk: false,
      discount_bulk_minimum_quantity: nil,
      discount_bulk_price: nil
    )

    @li = LineItem.new(@pricing_rule)
  end

  it { expect(@li).to respond_to(:pricing_rule) }
  it { expect(@li).to respond_to(:quantity) }

  describe 'total' do
    it 'should return pricing pricing for the given quantity' do
      @li.quantity = quantity = 5
      expect(@li.total).to eq(@pricing_rule.price_for(quantity))
    end
  end
end
