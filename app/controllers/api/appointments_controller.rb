class Api::AppointmentsController < ApplicationController
  def index
    #new array to hold created appointments
    @appointments = []

    # filter for past, future appointments
    if params[:past] == "1"
      appointments = Appointment.where("start_time < ?", Time.zone.now)
    elsif params[:past] == "0"
      appointments = Appointment.where("start_time > ?", Time.zone.now)

    #  paginated appointments
    elsif params[:page] && params[:length]
      limit = params[:length]
      offset = params[:page] - 1 * params[:length]
      appointments = Appointment.limit(limit).offset(offset)

    # return all scheduled appointments
    else
      appointments = Appointment.all
    end

    #push each appointment into the new array
    appointments.each do |ap|
      @appointments.push({
        id: ap.id,
        patient: { name: ap.patient.name },
        doctor: { name: ap.doctor.name, id: ap.doctor.id },
        created_at: ap.created_at,
        start_time: ap.start_time,
        duration_in_minutes: ap.duration_in_minutes
      })
    end
    render json: @appointments
  end

  def create
    appointment = Appointment.new(
      patient_id: Patient.where(name: params[:patient][:name]),
      doctor_id: params[:doctor][:id],
      start_time: params[:start_time],
      duration_in_minutes: params[:duration_in_minutes]
    )
    # save new appointment
    if appointment.save!
      render json: appointment, status: :created
    else
      render json: appointment.errors, status: :unprocessable_entity
    end
  end
end
