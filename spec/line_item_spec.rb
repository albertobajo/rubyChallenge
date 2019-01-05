require_relative '../lib/line_item'

describe LineItem do
  before(:each) do
    @line_item = LineItem.new
    @line_item.quantity = 3
    @line_item.price = 15.00
  end


  it { expect(@line_item).to respond_to(:code) }
  it { expect(@line_item).to respond_to(:discount_bulk_minimum_quantity) }
  it { expect(@line_item).to respond_to(:discount_bulk_price) }
  it { expect(@line_item).to respond_to(:discount_bulk) }
  it { expect(@line_item).to respond_to(:discount_two_for_one) }
  it { expect(@line_item).to respond_to(:price) }
  it { expect(@line_item).to respond_to(:quantity) }
  it { expect(@line_item).to respond_to(:total_price) }

  describe 'total_price' do
    subject { @line_item.total_price }

    it 'should raise an error if price is not a float' do
      @line_item.price = 15
      expect { subject }.to raise_error(TypeError)
    end

    it 'should raise an error if bulk price is not a float' do
      @line_item.discount_bulk_price = 15
      expect { subject }.to raise_error(TypeError)
    end

    context 'there is no discounts' do
      it { is_expected.to eq(45.00) }
    end

    context 'there is a 2-for-1 discount' do
      before { @line_item.discount_two_for_one = true }
      it { is_expected.to eq(30.00) }
    end

    context 'there is a bulk discount' do
      before do
        @line_item.discount_bulk = true
        @line_item.discount_bulk_price = 12.00
        @line_item.discount_bulk_minimum_quantity = 3
      end

      it { is_expected.to eq(36.00) }

      context 'quantity is less than bulk minimum' do
        before { @line_item.quantity = 2 }
        it { is_expected.to eq(30.00) }
      end

    end

    # TODO:
    # context 'there is both a 2-for-1 discount and a bulk discount' do
    #
    # end
  end
end
