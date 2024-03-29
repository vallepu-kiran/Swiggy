class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :add_to_cart, :remove_item, :increment_cart_quantity, :decrement_cart_quantity]

  def show
    @items_in_cart = @cart.cart_items.includes(:item)
    @items_in_cart = current_user.cart.cart_items.includes(:item)
    if user_signed_in? 
      @cart = current_user.cart || Cart.new
      @items_in_cart = @cart.cart_items
      @total_quantity = @items_in_cart.sum(&:quantity)
    else
      @cart = Cart.new
      @items_in_cart = []
      @total_quantity = 0
    end
    @address ||= Address.new
  end

  def add_to_cart
    @item = Item.find(params[:item_id])
    @current_restaurant = @item.restaurant

    if @cart.has_items_from_different_restaurant?(@current_restaurant)
      @cart.cart_items.destroy_all
      flash[:notice] = 'Your cart has been cleared because you added items from a different restaurant.'
    end

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
      item = find_item(item_id)
      if item
        cart_item = find_cart_item(item)
        if cart_item
          update_cart_item(cart_item)
        else
          handle_item_not_found
        end
      else
        handle_item_not_found
      end
    else
      handle_missing_item_id
    end
  end
  
  private
  
  def find_item(item_id)
    Item.find(item_id)
  rescue ActiveRecord::RecordNotFound
    nil
  end
  
  def find_cart_item(item)
    @cart.cart_items.find_by(item: item)
  end
  
  def update_cart_item(cart_item)
    cart_item.quantity -= 1
    cart_item.quantity.zero? ? cart_item.destroy : cart_item.save
  
    respond_to do |format|
      format.html {
        flash[:notice] = 'Item removed from cart'
        redirect_to cart_path
      }
      format.js
    end
  end
  
  def handle_item_not_found
    flash[:alert] = 'Item not found in the cart'
    respond_to do |format|
      format.html { redirect_to cart_path }
      format.js
    end
  end
  
  def handle_missing_item_id
    flash[:alert] = 'Item ID not provided'
    respond_to do |format|
      format.html { redirect_to cart_path }
      format.js
    end
  end
  

  private

  def set_cart
    @cart = current_user.cart || Cart.create!(user_id: current_user.id)
  end
end
