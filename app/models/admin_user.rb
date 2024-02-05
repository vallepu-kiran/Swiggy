# This is the AdminUser class, representing a model for administrative users in your application.
class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, 
         :rememberable, :validatable, :trackable
end
