class AddressesController < ApplicationController
  before_action :authenticate_user!

  def create 
    if Address.create(address_params)
      render json: "address added", status: :created
    else
      render json: { errors: "address not added" },
             status: :unprocessable_entity
    end
  end

  def show
    render json: UserDetail.find(params[:id]).address
  end

  def update 
    if Address.update(address_params)
      render json: "address updated", status: :ok
    else
      render json: { errors: "address not updated" },
             status: :unprocessable_entity
    end
  end

  def destroy
    if UserDetail.find(params[:id]).address.destroy
      render json: "address deleted", status: :ok
    else  
      render json: { errors: "address not deleted" },
             status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.require(:user_detail).permit(:locality, :city, :state, :pin, :user_detail_id)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
