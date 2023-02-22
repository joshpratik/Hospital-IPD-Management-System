class AdmissionsController < ApplicationController
  #before_action :authenticate_user!
  #load_and_authorize_resource :except => [:create]
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
    @admissions = Admission.where(admission_status: 'admitted')
    @admission_details = Array.new
    @admissions.each do |admission|
      @admission_details.push(
        {
          id: admission.id,
          patient: UserDetail.find(admission.patient_id).first_name,
          staff: UserDetail.find(admission.staff_id).first_name,
          room: Room.find(admission.room_id).room_type,
          dignostic: admission.dignostic,
          admission_date: admission.admission_date
        }
      )
    end
    if @admissions
      render json: {status: 'success', data: @admission_details }, status: :ok
    else
      render json: { errors: @admissions.errors.full_messages },
             status: :unprocessable_entity
    end
    # receipt_pdf = Prawn::Document.new
    # receipt_pdf.text 'My Text'
    # receipt_pdf.text 'My Styled Text', style: :bold
    # receipt_pdf.text 'My Sized Text', size: 20
    # receipt_pdf.text 'My Colored Text', color: '7f7f7f'
    # receipt_pdf.text 'My Aligned Text', align: :right
    # send_data receipt_pdf.render, filename: 'my_pdf_file.pdf', type: 'application/pdf', disposition: 'inline'
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
      @charges = Array.new
      @room = @admission.room
      no_of_days = (@admission.discharge_date - @admission.admission_date).to_i
      @total = no_of_days * @room.charges
      @charges.push([ 'Room Type', 
                      'Charges',
                      'Days',
                      'Total'
                    ],
                    [ @room.room_type, 
                      @room.charges,
                      no_of_days,
                      @total
                    ],['','','',''])
      @treatments = @admission.treatments
      @charges.push([
        'medicine',
        'price',
        'quantity',
        'total'
      ])
      @treatments.each do |treatment|
        medicine = treatment.medicine
        @charges.push([
          medicine.name,
          medicine.price,
          treatment.quantity,
          medicine.price * treatment.quantity
        ])
        @total += medicine.price * treatment.quantity
      end
      patient = "Patient Name: #{@admission.patient.first_name} #{@admission.patient.last_name}"
      admission_date = "Admission Date : #{@admission.admission_date}"
      discharge_date = "Discharge Date : #{@admission.discharge_date}"
      receipt_pdf = Prawn::Document.new
      receipt_pdf.text 'Hospital IPD Management System', align: :center, style: :bold, size: 20
      receipt_pdf.text 'Invoice', align: :center, size: 18
      receipt_pdf.text patient, align: :center, size: 15
      receipt_pdf.text admission_date, align: :center, size: 15
      receipt_pdf.text discharge_date, align: :center, size: 15
      receipt_pdf.table @charges, :position => :center # table_data used from previous step
      receipt_pdf.text '__________________________________________________________', align: :center
      receipt_pdf.table [["Final Total", @total]], :position => :center
      send_data receipt_pdf.render, type: 'application/pdf', disposition: 'inline'
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
