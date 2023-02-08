class MedicinesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :except => [:create]
  before_action :set_medicine, only: %i[show update]


  def create 
    authorize! :create, Medicine
    @medicine = Medicine.new(medicine_params)
    if @medicine.save
      render json: @medicine, status: :created
    else
      render json: { errors: @medicine.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def index 
    @medicines = Medicine.all
    if @medicines
      render json: {status: 'success', data: @medicines }, status: :ok
    else
      render json: { errors: @medicines.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def show
    if @medicine 
      render json: @medicine, status: :ok
    else
      render status: :unprocessable_entity
    end
  end

  def update
    if @medicine.update(medicine_params)
      render json: @medicine, status: :ok
    else
      render json: { errors: @medicine.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def medicine_params
    params.require(:medicine).permit(:name, :price)
  end

  def set_medicine
    @medicine = Medicine.find(params[:id])
  end

end
