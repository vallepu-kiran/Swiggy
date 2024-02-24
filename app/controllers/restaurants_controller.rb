class RestaurantsController < ApplicationController
    def show
      @restaurant = Restaurant.find(params[:id])
      @items = @restaurant.items
     
    end

    
  end