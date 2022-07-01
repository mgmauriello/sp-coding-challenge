=begin
return all appointments in the appt contraoller
need to create new appt where there is a patient, dr, starttime, dur
save appt through render json if error status 401
=end
class Api::AppointmentsController < ApplicationController
  def index
    # TODO: return all values
    # TODO: return filtered values
    head :ok
  end

  def create
  #   appointment = Appointment.new(
  #     patient_id: { name: <string> },
  #     doctor_id : { name: <string>, id: <int> },
  #     created_at: <iso8601>,
  #     start_time: <iso8601>,
  #     duration_in_minutes: <int>
  #   )
  # end
end
