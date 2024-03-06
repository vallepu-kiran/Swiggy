class Item < ApplicationRecord
  belongs_to :restaurant
  has_many :cart_items

  def self.search(query)
    where("name LIKE ?", "%#{query}%")
  end
end
