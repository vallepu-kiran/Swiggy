class RestaurantsController < ApplicationController
    def show
      @restaurant = Restaurant.find(params[:id])
      @items = @restaurant.items
      @cart = current_user.cart || current_user.build_cart
    end

    
  end