class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :except => [:create]

  def create
    authorize! :create, User  
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
