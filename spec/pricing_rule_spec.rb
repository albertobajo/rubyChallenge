require_relative '../lib/pricing_rule'

describe PricingRule do
  let(:quantity) { 3 }
  let(:discount_bulk_minimum_quantity) { 3 }

  before(:each) do
    @rule = PricingRule.new(
      code: "VOUCHER",
      name: "Cabify Voucher",
      price: 15.00,
      discount_two_for_one: false,
      discount_bulk: false,
      discount_bulk_minimum_quantity: discount_bulk_minimum_quantity,
      discount_bulk_price: 12.0
    )
  end

  it { expect(@rule).to respond_to(:code) }
  it { expect(@rule).to respond_to(:discount_bulk_minimum_quantity) }
  it { expect(@rule).to respond_to(:discount_bulk_price) }
  it { expect(@rule).to respond_to(:discount_bulk) }
  it { expect(@rule).to respond_to(:discount_two_for_one) }
  it { expect(@rule).to respond_to(:price) }
  it { expect(@rule).to respond_to(:calculate) }

  describe 'calculate' do
    subject { @rule.calculate(quantity) }

    it 'should raise an error if price is not a float' do
      @rule.price = 15

      expect { subject }.to raise_error(TypeError)
    end

    it 'should raise an error if bulk price is not a float' do
      @rule.discount_bulk_price = 15

      expect { subject }.to raise_error(TypeError)
    end

    it 'should calculate total price' do
      expect(subject).to eq(45.00)
    end

    it 'should calculate a 2-for-1 discount if applies' do
      @rule.discount_two_for_one = true

      expect(subject).to eq(30.00)
    end

    context 'there is a bulk discount' do
      before do
        @rule.discount_bulk = true
      end

      it 'should apply a bulk discount' do
        expect(subject).to eq(36.00)
      end

      context 'quantity is less than minimum' do
        let(:quantity) { discount_bulk_minimum_quantity - 1 }

        it { expect(subject).to eq(30.00) }
      end
    end
  end
end
