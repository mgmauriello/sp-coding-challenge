=begin
for create: return all appointments in the appt contraoller
  need to create new appt where there is a patient, dr, starttime, dur
  find patient/dr where their name meets parameters of patient
  save appt through render json if error status 401
for filter: if past == 1, return the key [:past] appts where the
  appt start time less than the point of origin at the current time
  if past == 0, return future appts where the appt start time
    greater than the point of origin at the current time
  return paginated appts, using limit method to limit
    to tell the number of records to be fetched, and use offset
      to tell the number of records to skip before starting to
      return the records.
  limit per page, offset page
=end
class Api::AppointmentsController < ApplicationController
  def index
    # filter for past, future, and all appointments
    if params[:past] === "1"
      @appointments = Appointment.where("start_time < ?", Time.zone.now)
    elsif params [:past] === "0"
      @appointments = Appointment.where("start_time > ?", Time.zone.now)
    else
      @appointment = Appointment.all
      render json: @appointment
    end
    @appointments = appointments.order(start_time: :asc).limit(params[:length]).offset(params[:page])
  end

  def create
    @appointment = Appointment.new(
      patient_id: Patient.where(name: params[:patient][:name]),
      doctor_id: params[:doctor][:id],
      start_time: params[:start_time],
      duration_in_minutes: params[:duration_in_minutes]
    )
    # save new appointment as json or return error
    if @appointment.save
      render json: @appointment, status: :created, location: @appointment
    else
      render json: @appointment.errors, status: :unprocessable_entity
    end
  end
end
