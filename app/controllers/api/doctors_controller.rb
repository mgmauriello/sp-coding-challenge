class Api::DoctorsController < ApplicationController
  def index
    # returns every doctor without an appointment scheduled
    doctors = Doctor.where.not(id: Appointment.all.map(&:doctor_id))
    render json: doctors
  end
end
