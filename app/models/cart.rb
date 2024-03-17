class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def has_items_from_different_restaurant?(current_restaurant)
    return false if cart_items.empty?
    cart_items.any? { |cart_item| cart_item.item.restaurant != current_restaurant }
  end
end
