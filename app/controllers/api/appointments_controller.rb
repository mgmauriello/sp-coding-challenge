=begin
for create: return all appointments in the appt contraoller
  need to create new appt where there is a patient, dr, starttime, dur
  find patient/dr where their name meets parameters of patient
  save appt through render json if error status 401
for filter: if past == 1, return the key [:past] appts where the
  appt start time less than the point of origin at the current time
  if past == 0, return future appts where the appt start time
    greater than the point of origin at the current time
=end
class Api::AppointmentsController < ApplicationController
  def index
    if params[:past] === 1
      @appointments = Appointment.where("start_time < ?", Time.zone.now)
    elsif params [:past] === 0
      @appointments = Appointment.where("start_time > ?", Time.zone.now)
    else
      @appointment = Appointment.all
      render json: @appointment
    end

  end

  def show
    render json: @appointment
  end

  def create
    @appointment = Appointment.new(
      patient_id: Patient.where(name: params[:patient][:name][:id]),
      doctor_id: params[:doctor][:id],
      start_time: params[:start_time],
      duration_in_minutes: params[:duration_in_minutes]
    )
    if @appointment.save
      render json: @appointment, status: :created, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end
end
