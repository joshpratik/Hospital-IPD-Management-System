class RoomsController < ApplicationController
  
  def create 
    if Room.create(room_params)
      render json: "room added", status: :created
    else
      render json: { errors: "room not added" },
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
      render json: { errors: @room.errors.full_message },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @room.destroy
      render json: "room deleted", status: :success
    else
      render json: { errors: @room.errors.full_message },
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
