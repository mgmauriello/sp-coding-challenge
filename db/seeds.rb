# TODO: Seed the database according to the following requirements:
# -1. There should be 10 Doctors with unique names
# -2. Each doctor should have 10 patients with unique names
# -3. Each patient should have 10 appointments (5 in the past, 5 in the future)
#   -3.5 Each appointment should be 50 minutes in duration

require 'faker'

Doctor.destroy_all
Patient.destroy_all
Appointment.destroy_all

10.times do
  doctor = Doctor.create(
    name: Faker::Name.unique.name
  )

  10.times do
    # patients per doctor
    patient = Patient.create(
      doctor_id: doctor.id,
      name: Faker::Name.unique.name
    )

    # appointment per patient
     5.times do
      Appointment.create(
        patient_id: patient.id,
        doctor_id: patient.doctor_id,
        start_time: Faker::Time.backward(days: 90, period: :day, format: :long),
        duration_in_minutes: 50
      )
    end

    5.times do
      Appointment.create(
        patient_id: patient.id,
        doctor_id: patient.doctor_id,
        start_time: Faker::Time.forward(days: 90,  period: :day, format: :long),
        duration_in_minutes: 50
      )
    end
  end
end
