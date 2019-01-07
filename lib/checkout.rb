class Checkout
  def initialize(pricing_rules)
    @line_items = {}

    Struct.new('LineItem', :pricing_rule, :quantity) do
      def total
        pricing_rule.price_for quantity
      end
    end

    pricing_rules.each { |r| @line_items[r.code] = Struct::LineItem.new(r, 0) }
  end

  def scan(code)
    @line_items[code].quantity += 1
  end

  def total
    "%.2f€" % @line_items.values.sum(&:total)
  end
end
