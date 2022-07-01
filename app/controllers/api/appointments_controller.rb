=begin
return all appointments in the appt contraoller
need to create new appt where there is a patient, dr, starttime, dur
find patient/dr where their name meets parameters of patient

save appt through render json if error status 401
=end
class Api::AppointmentsController < ApplicationController
  def index
    # TODO: return all values
    # TODO: return filtered values
    head :ok
  end

  def create
    @appointment = Appointment.new(
      patient_id: Patient.where(name: params[:patient][:name][:id]),
      doctor_id: params[:doctor][:id],
      start_time: params[:start_time],
      duration_in_minutes: params[:duration_in_minutes]
    )
    if @appointment.save
      render json: @appointment
    else
      render json: {status: 401}
    end
  end
end
