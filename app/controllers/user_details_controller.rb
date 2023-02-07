class UserDetailsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :except => [:create]
  before_action :set_user, only: %i[show destroy update]

  def index 
    if current_user.user_detail.role.name == 'admin'
      render json: {staff: UserDetail.where(role_id: Role.find_by(name:'staff')),
                    patients: UserDetail.where(role_id: Role.find_by(name:'patient'))}, 
        status: :ok
    else
      render json: UserDetail.where(role_id: Role.find_by(name:'patient')), status: :ok
    end
  end

  def create
    authorize! :create, UserDetail
    @user = UserDetail.new(user_params)
    if current_user.user_detail.role.name == 'admin'
      @user.role = Role.find_by(name: 'staff')
    else
      @user.role = Role.find_by(name: 'patient')
    end
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
              status: :unprocessable_entity
    end
  end

  def show 
    if @user
      render json: @user, status: :ok
    else
      render json: { errors: @user.errors.full_messages },
              status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: "user updated", status: :ok
    else
      render json: { errors: @user.errors.full_messages },
                     status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user_detail).permit(:first_name, :last_name, :date_of_birth, :gender, :phone_no, :user_id)
  end

  def set_user
    @user = UserDetail.find(params[:id])
  end
end
  
