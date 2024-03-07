class Restaurant < ApplicationRecord
    has_many :items, dependent: :destroy
    
    def self.search(query)
        where("name LIKE ?", "%#{query}%")
      end
end
