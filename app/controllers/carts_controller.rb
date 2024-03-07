class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :add_to_cart, :remove_item, :increment_cart_quantity, :decrement_cart_quantity]

  def show
    @items_in_cart = @cart.cart_items.includes(:item)
    @items_in_cart = current_user.cart.cart_items.includes(:item)
    @total_quantity = @items_in_cart.compact.sum { |item| item.quantity.to_i }
    
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
    if params[:item][:return_type] == 'cart'
      render 'refresh_cart'
    else
      render 'add_to_cart'
    end
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
    if params[:item][:return_type] == 'cart'
      render 'refresh_cart'
    else
      render 'add_to_cart'
    end
  end
  def remove_item
    item_id = params.dig(:cart_item, :item_id)
    if item_id
      item = Item.find(item_id)
      cart_item = @cart.cart_items.find_by(item: item)
      if cart_item
        cart_item.quantity -= 1
        cart_item.quantity.zero? ? cart_item.destroy : cart_item.save
        respond_to do |format|
          format.html {
            flash[:notice] = 'Item removed from cart'
            redirect_to cart_path
          }
          format.js
        end
      else
        flash[:alert] = 'Item not found in the cart'
        respond_to do |format|
          format.html { redirect_to cart_path }
          format.js
        end
      end
    else
      flash[:alert] = 'Item ID not provided'
      respond_to do |format|
        format.html { redirect_to cart_path }
        format.js
      end
    end
  end
  

  private

  def set_cart
    @cart = current_user.cart || current_user.build_cart
  end
end
