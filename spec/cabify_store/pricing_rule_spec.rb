require 'cabify_store'

describe PricingRule do
  # See spec/support/cabify_store_helpers.rb
  subject { pricing_rule }

  before { subject.price = 7.50 }

  it { is_expected.to respond_to(:code) }
  it { is_expected.to respond_to(:discount_bulk_minimum_quantity) }
  it { is_expected.to respond_to(:discount_bulk_price) }
  it { is_expected.to respond_to(:discount_bulk) }
  it { is_expected.to respond_to(:discount_two_for_one) }
  it { is_expected.to respond_to(:price) }
  it { is_expected.to respond_to(:calculate) }

  describe 'calculate' do
    context 'quantity is zero' do
      it { expect(subject.calculate(0)).to eq(0.0) }
    end

    context 'quantity is negative' do
      it { expect(subject.calculate(-1)).to eq(0.0) }
    end

    context 'quantity is positive' do
      let(:quantity) { 2 }

      context 'without discount' do
        it { expect(subject.calculate(quantity)).to eq(15.0) }
      end

      context 'with discount' do
        context '2-for-1' do
          before { subject.discount_two_for_one = true }
          it { expect(subject.calculate(quantity)).to eq(7.5) }
        end

        context 'bulk' do
          before do
            subject.discount_bulk = true
            subject.discount_bulk_minimum_quantity = 2
            subject.discount_bulk_price = 5.00
          end

          context 'quantity is less than minimum' do
            let(:quantity) { 1 }
            it { expect(subject.calculate(quantity)).to eq(7.50) }
          end

          context 'quantity is equal to minimum' do
            let(:quantity) { 2 }
            it { expect(subject.calculate(quantity)).to eq(10.0) }
          end

          context 'quantity is greater than minimum' do
            let(:quantity) { 3 }
            it { expect(subject.calculate(quantity)).to eq(15.0) }
          end
        end

        context 'both' do
          it '2-for-1 takes precedence' do
            subject.discount_two_for_one = true
            subject.discount_bulk = true
            subject.discount_bulk_minimum_quantity = 2
            subject.discount_bulk_price = 5.00

            expect(subject.calculate(2)).to eq(7.5)
          end
        end
      end
    end
  end
  
end
