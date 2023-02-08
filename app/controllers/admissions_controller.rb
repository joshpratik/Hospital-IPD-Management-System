class AdmissionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource :except => [:create]
  before_action :set_admission, only: %i[show destroy update invoice]

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
    
    if @admission.errors.count == 0
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

  def index
    @admissions = Admission.all
    if @admissions
      render json: {status: 'success', data: @admissions }, status: :ok
    else
      render json: { errors: @admissions.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @admission
      if @admission.update(admission_params)
        render json: {status: 'success', data: @admission }, status: :ok
      else
        render json: { errors: @admission.errors.full_messages },
             status: :unprocessable_entity
      end
    else
      render json: { errors: @admission.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy 
    if @admission
      if @admission.update(admission_status: 'discharged', discharge_date: Time.now.strftime("%Y-%m-%d"))
        @availibility = AvailableResource.find_by(room_id: @admission.room_id)
        @availibility.update(available_capacity: @availibility.available_capacity+1)
        render json: {status: 'success', data: @admission }, status: :ok
      else
        render json: { errors: @admission.errors.full_message },
             status: :unprocessable_entity
      end
    else
      render json: { errors: @admission.errors.full_message },
             status: :unprocessable_entity
    end
  end

  def invoice 
    if @admission
      @medicine_charges = Array.new
      @room = @admission.room
      no_of_days = (@admission.discharge_date - @admission.admission_date).to_i
      @total = no_of_days * @room.charges
      @room_charges = {room_type: @room.room_type, 
                     charges: @room.charges,
                     no_of_days: no_of_days,
                     room_total: @total
                    }
      @treatments = @admission.treatments
      @treatments.each do |treatment|
        medicine = treatment.medicine
        @medicine_charges.push({
          medicine: medicine.name,
          price: medicine.price,
          quantity: treatment.quantity,
          total: medicine.price * treatment.quantity
        })
        @total += medicine.price * treatment.quantity
      end
      render json: { room_charges: @room_charges, medicine_charges: @medicine_charges, total: @total },
                     status: :ok
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
