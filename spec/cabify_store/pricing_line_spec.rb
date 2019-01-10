describe PricingLine do
  # See spec/support/cabify_store_helpers.rb
  let(:rule) { pricing_rule}
  let(:quantity) { 3 }
  subject { described_class.new(pricing_rule, quantity) }

  it { is_expected.to respond_to(:quantity) }
  it { is_expected.to respond_to(:total) }

  describe 'total' do
    it 'invokes calculate with quantity' do
      is_expected.to receive(:calculate).with(quantity).once
      subject.total
    end
  end
end
