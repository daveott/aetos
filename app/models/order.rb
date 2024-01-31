class Order < ApplicationRecord
  belongs_to :product

  scope :last_month, -> { where('orders.created_at > ?', 1.month.ago) }
  scope :frequently_ordered, -> {
    joins(:product)
     .group(:product_id, :name)
     .having('count(*) > 1')
     .limit(3)
     .order("count_all DESC")
     .count
  }
end
