class RoomsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :except => [:create]
  before_action :set_room, only: %i[show destroy update]

  
  def create 
    authorize! :create, Room
    @room = Room.new(room_params)
    if @room.save
      render json: @room, status: :created
    else
      render json: { errors: @room.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def show
    if @room 
      render json: @room, status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def update
    if @room.update(room_params)
      render json: @room, status: :ok
    else
      render json: { errors: @room.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def room_params
    params.require(:room).permit(:room_type, :description, :charges, :capacity)
  end

  def set_room
    @room = Room.find(params[:id])
  end
end
