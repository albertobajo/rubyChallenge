require 'cabify_store/checkout'

describe Checkout do
  let(:pricing_rules) {
    [
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
  }

  before(:each) do
    @co = Checkout.new(pricing_rules)
  end

  it { expect(@co).to respond_to(:scan) }
  it { expect(@co).to respond_to(:total) }

  describe 'total' do
    context 'there is no items scanned' do
      it { expect(@co.total).to eq("0.00€") }
    end

    context 'there is different items scanned in any order' do
      it 'should apply the pricing rules' do
        @co.scan('VOUCHER')
        @co.scan('TSHIRT')
        @co.scan('VOUCHER')
        @co.scan('VOUCHER')
        @co.scan('MUG')
        @co.scan('TSHIRT')
        @co.scan('TSHIRT')

        expect(@co.total).to eq("74.50€")
      end
    end
  end
end
