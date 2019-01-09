describe PricingLine do
  let(:quantity) { 3 }

  before(:each) do
    @rule = PricingRule.new(
      code: "VOUCHER",
      name: "Cabify Voucher",
      price: 15.00,
      discount_two_for_one: false,
      discount_bulk: false,
      discount_bulk_minimum_quantity: nil,
      discount_bulk_price: nil
    )

    @pricing_line = described_class.new(@rule, quantity)
  end

  it { expect(@pricing_line).to respond_to(:quantity) }
  it { expect(@pricing_line).to respond_to(:total) }

  describe 'total' do
    it 'should be equal to calculate call for given quantity' do
      expect(@pricing_line.total).to eq(@pricing_line.calculate(quantity))
    end
  end
end
