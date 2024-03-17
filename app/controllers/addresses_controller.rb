class AddressesController < ApplicationController
    before_action :authenticate_user! 
    before_action :set_address, only: [:show, :edit, :update, :destroy]
  
    def index
      @addresses = current_user.addresses
    end
  
    def show
      # Your code for showing a specific address
    end
  
    def new
      @address = Address.new
    end
  
    def create
      @address = current_user.addresses.build(address_params)
  
      if @address.save
        redirect_to addresses_path, notice: 'Address was successfully created.'
      else
        render :new
      end
    end
  
    def edit
      # Your code for editing a specific address
    end
  
    def update
      if @address.update(address_params)
        redirect_to addresses_path, notice: 'Address was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @address.destroy
      redirect_to addresses_path, notice: 'Address was successfully destroyed.'
    end
  
    private
  
    def set_address
      @address = current_user.addresses.find(params[:id])
    end
  
    def address_params
      params.require(:address).permit(:location, :landmark, :door_number, :address_type, :other_address_type)
    end
  end
  