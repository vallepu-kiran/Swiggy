class RestaurantsController < ApplicationController
  def show
    @restaurant = Restaurant.find(params[:id])
    @items = @restaurant.items

    if user_signed_in? 
      @cart = current_user.cart || Cart.new
      @items_in_cart = @cart.cart_items
      @total_quantity = @items_in_cart.sum(&:quantity)
    else
      @cart = Cart.new
      @items_in_cart = []
      @total_quantity = 0
    end
  end
end
