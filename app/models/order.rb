class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :order_items
  def delivered?
    delivered_at.present?
  end
  def total_order_amount_with_taxes_and_discounts
    total_amount + taxes - discount
  end
end
