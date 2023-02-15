class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :except => [:create]

  def create
    authorize! :create, User 
    @user = User.new(user_params)
    pass = SecureRandom.hex(6)
    @user.password = pass
    if @user.save
      WelcomeMailer.with(user: @user).welcome_mail(pass).deliver_later
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
