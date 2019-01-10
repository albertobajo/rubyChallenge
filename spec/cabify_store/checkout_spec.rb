describe Checkout do
  # See spec/support/cabify_store_helpers.rb
  subject { described_class.new(pricing_rules) }

  it { is_expected.to respond_to(:scan) }
  it { is_expected.to respond_to(:total) }

  describe 'scan' do
    let(:pricing_lines) { subject.instance_variable_get(:@pricing_lines) }

    context 'code is valid' do
      let(:code) { 'VOUCHER' }

      it { expect(subject.scan(code)).to eq(true) }

      it 'line item quantity is increased by 1' do
        expect {
          subject.scan code
        }.to change{ pricing_lines[code].quantity }.by(1)
      end
    end

    context 'code is invalid' do
      let(:code) { '' }

      it { expect(subject.scan(code)).to eq(false) }

      it 'there is not a new key at pricing_lines' do
        subject.scan(code)
        expect(pricing_lines.key?(code)).to eq(false)
      end
    end
  end

  describe 'total' do
    context 'without scanned items' do
      it { expect(subject.total).to eq('0.00€') }
    end

    context 'with scanned items' do
      before do
        subject.scan('VOUCHER') # 5.00€
        subject.scan('MUG') # 7.50€
        subject.scan('TSHIRT') # 20.00€
      end

      it 'returns the sum of each pricing line' do
        expect(subject.total).to eq('32.50€')
      end
    end
  end
end
