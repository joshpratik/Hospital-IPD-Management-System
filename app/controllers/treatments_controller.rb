class TreatmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_treatment, only: %i[add]

  def add 
    if @treatment
      @treatment.update(quantity: @treatment.quantity + params[:quantity])
    else
      Treatment.create(treatment_params)
    end
  end

  private

  def set_treatment
    @treatment = Treatment.find_by(admission_id: params[:admission_id], medicine_id:params[:medicine_id])
  end

  def treatment_params
    params.require(:treatment).permit(:admission_id, :medicine_id, :quantity)
  end
end
