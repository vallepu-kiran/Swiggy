class SearchController < ApplicationController
  def index
    @restaurants = Restaurant.search(params[:query])
    @items = Item.search(params[:query])
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
