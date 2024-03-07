# The UsersController class is responsible for users
class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
   end
end


