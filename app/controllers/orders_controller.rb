class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = current_user.orders
  end

  
  def show
  end

  
  def new
    @order = Order.new
  end

  
  def edit
  end

  
  def create
    @order = current_user.orders.build(order_params)

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  
  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  
  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end

  private
    
    def set_order
      @order = current_user.orders.find(params[:id])
    end

   .
    def order_params
      params.require(:order).permit(:restaurant_id, :total_amount, :platform_fee, :paid_via, :paid_type, :taxes, :discount, :delivered_at, :platform)
    end
end
