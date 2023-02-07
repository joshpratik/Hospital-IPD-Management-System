class AddressesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :except => [:create]
  before_action :set_address, only: %i[show update]

  def create 
    authorize! :create, Address
    @address = Address.new(address_params)
    if @address.save
      render json: @address, status: :created
    else
      render json: { errors: @address.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def show
    if @address
      render json: @address, status: :ok
    else
      render json: { errors: @address.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update 
    if @address.update(address_params)
      render json: @address, status: :ok
    else
      render json: { errors: @address.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.require(:address).permit(:locality, :city, :state, :pin, :user_detail_id)
  end

  def set_address
    @address = Address.find(params[:id])
  end
end
