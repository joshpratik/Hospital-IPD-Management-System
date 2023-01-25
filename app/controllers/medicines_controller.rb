class MedicinesController < ApplicationController

  def create 
    if Medicine.create(medicine_params)
      render json: "medicine added", status: :created
    else
      render json: { errors: "medicine not added" },
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
      render json: { errors: @medicine.errors.full_message },
             status: :unprocessable_entity
    end
  end

  def destroy
    if @medicine.destroy
      render json: "medicine deleted", status: :success
    else
      render json: { errors: @medicine.errors.full_message },
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
