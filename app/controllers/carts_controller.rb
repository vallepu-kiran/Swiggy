class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :add_to_cart, :remove_item, :increment_cart_quantity, :decrement_cart_quantity]

  def show
    @items_in_cart = @cart.cart_items.includes(:item)
    
  end

  def add_to_cart
    @item = Item.find(params[:item_id])
    @cart_item = @cart.cart_items.find_or_create_by(item: @item)
    @cart_item.increment!(:quantity)

    respond_to do |format|
      format.html { redirect_to cart_path, notice: 'Item added to cart' }
      format.js
    end
  end

  def increment_cart_quantity
    @item = Item.find(params[:id])
    @cart_item = @cart.cart_items.find_or_create_by(item: @item)

    @cart_item.increment!(:quantity)
    @cart_item.reload
    render 'add_to_cart'
  end

  def remove_item
    item_id = params.dig(:cart_item, :item_id) 
  
    if item_id
      item = Item.find(item_id)
      cart_item = @cart.cart_items.find_by(item: item)
  
      if cart_item
        cart_item.quantity -= 1
        cart_item.quantity.zero? ? cart_item.destroy : cart_item.save
        flash[:notice] = 'Item removed from cart'
      else
        flash[:alert] = 'Item not found in the cart'
      end
    else
      flash[:alert] = 'Item ID not provided'
    end
  
    redirect_to cart_path
  end
  def decrement_cart_quantity
    @item = Item.find(params[:id])
    @cart_item = @cart.cart_items.find_or_create_by(item: @item)
  
    if @cart_item.quantity > 1
      @cart_item.decrement!(:quantity)
      @cart_item.reload
    else
      @cart_item.destroy
    end
    render 'add_to_cart'

  end

  private

  def set_cart
    @cart = current_user.cart || current_user.build_cart
  end
end




