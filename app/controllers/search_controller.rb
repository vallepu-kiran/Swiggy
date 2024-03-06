class SearchController < ApplicationController
  def index
    @restaurants = Restaurant.search(params[:query])
    @items = Item.search(params[:query])
    @items_in_cart = CartItem.all  
    @total_quantity = @items_in_cart.sum(&:quantity)
  end
end
