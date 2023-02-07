class AdmissionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :except => [:create]
  before_action :set_admission, only: %i[show destroy update]

  def create
    authorize! :create, Admission
    @availibility = AvailableResource.find_by(room_id: admission_params[:room_id])
    if @availibility.available_capacity > 0
      @admission = Admission.new(admission_params)
      @admission.admission_status = 'admitted'
      @admission.save
    else
      render json: { errors: "Not Enough Capacity Available" },
             status: :unprocessable_entity
      return
    end
    
    if @admission
      @availibility.update(available_capacity: @availibility.available_capacity-1)
      render json: {status: 'success', data: @admission }, status: :created
    else
      render json: { errors: @admission.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def show
    if @admission
      render json: {status: 'success', data: @admission }, status: :ok
    else
      render json: { errors: @admission.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @admission
      @admission.update(admission_params)
      render json: {status: 'success', data: @admission }, status: :ok
    else
      render json: { errors: @admission.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy 
    if @admission
      if @admission.update(admission_status: 'discharged')
        @availibility = AvailableResource.find_by(room_id: @admission.room_id)
        @availibility.update(available_capacity: @availibility.available_capacity+1)
      else
        render json: { errors: @admission.errors.full_message },
             status: :unprocessable_entity
      end
    else
      render json: { errors: @admission.errors.full_message },
             status: :unprocessable_entity
    end
  end

  private

  def admission_params
    params.require(:admission).permit(:admission_date, :discharge_date, :dignostic, :admission_status, :patient_id, :staff_id, :room_id)
  end

  def set_admission
    @admission = Admission.find(params[:id])
  end
end
