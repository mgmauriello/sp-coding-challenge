class Api::AppointmentsController < ApplicationController
  def index
    # filter for past, future, and all appointments
    if params[:past] == "1"
      @appointments = Appointment.where("start_time < ?", Time.zone.now)
    elsif params [:past] == "0"
      @appointments = Appointment.where("start_time > ?", Time.zone.now)
    else
      @appointment = Appointment.all
      render json: @appointment
    end
    @appointments = appointments.order(start_time: :asc).limit(params[:length]).offset(params[:page])
    render json: @appointments
  end

  def create
    @appointment = Appointment.new(
      patient_id: Patient.where(name: params[:patient][:name]),
      doctor_id: params[:doctor][:id],
      start_time: params[:start_time],
      duration_in_minutes: params[:duration_in_minutes]
    )
    # save new appointment
    if @appointment.save
      render json: @appointment, status: :created, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end
end
