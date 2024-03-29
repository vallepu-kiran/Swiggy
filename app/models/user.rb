# This is the User class, representing a model for user accounts in your application.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :cart
  has_many :cart_items, through: :cart
  validates :User_name, presence: true
  has_many :addresses
end
