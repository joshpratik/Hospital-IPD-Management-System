class TreatmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_treatment, only: %i[create]

  def create 
    authorize! :create, Treatment
    if @treatment
      if @treatment.update(quantity: @treatment.quantity + treatment_params[:quantity].to_i)
        render json: @treatment, status: :ok
      else
        render json: { errors: @treatment.errors.full_messages },
             status: :unprocessable_entity
      end
    else
      @treatment = Treatment.new(treatment_params)
      if @treatment.save
        render json: @treatment, status: :created
      else
        render json: { errors: @treatment.errors.full_messages },
               status: :unprocessable_entity
      end
    end
  end

  private

  def set_treatment
    @treatment = Treatment.find_by(admission_id: treatment_params[:admission_id], medicine_id: treatment_params[:medicine_id])
  end

  def treatment_params
    params.require(:treatment).permit(:admission_id, :medicine_id, :quantity)
  end
end
