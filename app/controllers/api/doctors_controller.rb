=begin
Create a new endpoint that returns all doctors that
do not have an appointment.
need to create class dedicated for the doctors controller in the appcont
define doctors where doctors do not match an appointment at the dr id
  return doctors
=end
class Api::DoctorsController < ApplicationController
  def index
    # returns every doctor without an appointment scheduled
    doctors = Doctor.where.not(id: Appointment.all.map(&:doctor_id))

    render json: doctors
  end
end
