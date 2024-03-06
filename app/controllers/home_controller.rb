class HomeController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @items_in_cart = CartItem.all  
    @total_quantity = @items_in_cart.compact.sum { |item| item.quantity.to_i }
 end
end