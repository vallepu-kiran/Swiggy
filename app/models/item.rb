class Item < ApplicationRecord
  belongs_to :restaurant
  has_many :cart_items
end
