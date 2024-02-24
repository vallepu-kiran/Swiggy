class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :add_to_cart, :remove_item]

  def show
    @items_in_cart = @cart.cart_items.includes(:item)
    @total_quantity = @items_in_cart.sum(&:quantity)
  end

  def add_to_cart
    item = Item.find(params[:item_id])
    @cart.cart_items.find_or_create_by(item: item).increment!(:quantity)

    respond_to do |format|
      format.html { redirect_to cart_path, notice: 'Item added to cart' }
      format.js
    end
  end
  def remove_item
    
    item = Item.find(params[:item][:item_id])
  
    if item
      cart_item = @cart.cart_items.find_by(item: item)
  
      if cart_item
        cart_item.quantity -= 1
        cart_item.quantity.zero? ? cart_item.destroy : cart_item.save
        flash[:notice] = 'Item removed from cart'
      else
        flash[:alert] = 'Item not found in the cart'
      end
    else
      flash[:alert] = 'Item not found'
    end
  
    redirect_to cart_path
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.build_cart
  end
end




