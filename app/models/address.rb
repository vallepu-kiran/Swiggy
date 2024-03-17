class Address < ApplicationRecord
  belongs_to :user
  enum address_type: { home: 0, work: 1, other: 2 }
end
