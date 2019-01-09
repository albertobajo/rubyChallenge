describe Checkout do
  # See spec/support/cabify_store_helpers.rb
  let(:pricing_rules) { create_pricing_rules }
  subject { described_class.new(pricing_rules) }

  it { is_expected.to respond_to(:total) }
  it { is_expected.to respond_to(:scan) }

  describe 'total' do
    context 'there is no items scanned' do
      it { expect(subject.total).to eq("0.00€") }
    end

    context 'there is different items scanned in any order' do
      it 'should apply the pricing rules' do
        subject.scan('VOUCHER')
        subject.scan('TSHIRT')
        subject.scan('VOUCHER')
        subject.scan('VOUCHER')
        subject.scan('MUG')
        subject.scan('TSHIRT')
        subject.scan('TSHIRT')

        expect(subject.total).to eq("74.50€")
      end
    end
  end
end
