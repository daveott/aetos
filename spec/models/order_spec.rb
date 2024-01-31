require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:product) { Product.create(name: 'Test Product') }

  describe '.last_month' do
    let!(:old_order) { Order.create(product:, created_at: 2.months.ago) }
    let!(:recent_order) { Order.create(product:, created_at: 2.weeks.ago) }

    it 'returns orders created in the last month' do
      expect(Order.last_month).to eq([recent_order])
    end
  end

  describe '.frequently_ordered' do
    let(:product_1) { Product.create(name: 'Product 1') }
    let(:product_2) { Product.create(name: 'Product 2') }
    let(:product_3) { Product.create(name: 'Product 3') }
    let(:product_4) { Product.create(name: 'Product 4') }

    let!(:order_1) { Order.create(product: product_1) }
    let!(:order_2) { Order.create(product: product_1) }
    let!(:order_3) { Order.create(product: product_1) }
    let!(:order_4) { Order.create(product: product_2) }
    let!(:order_5) { Order.create(product: product_2) }
    let!(:order_6) { Order.create(product: product_2) }
    let!(:order_7) { Order.create(product: product_3) }
    let!(:order_8) { Order.create(product: product_3) }
    let!(:order_9) { Order.create(product: product_2) }

    it 'returns the most frequently ordered products, DESC count' do
      expect(Order.frequently_ordered).to eq({
        [product_2.id, 'Product 2'] => 4,
        [product_1.id, 'Product 1'] => 3,
        [product_3.id, 'Product 3'] => 2
      })
    end

    context 'ordered in the last month' do
      let!(:order_10) { Order.create(product: product_2, created_at: 1.week.ago) }
      let!(:order_11) { Order.create(product: product_4, created_at: 3.months.ago) }
      let!(:order_12) { Order.create(product: product_4, created_at: 3.months.ago) }

      it 'returns the most frequently ordered products in the last month, DESC count' do
        expect(Order.last_month.frequently_ordered).to eq({
          [product_2.id, 'Product 2'] => 5,
          [product_1.id, 'Product 1'] => 3,
          [product_3.id, 'Product 3'] => 2
        })
      end
    end
  end
end
