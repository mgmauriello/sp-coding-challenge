# TODO: Seed the database according to the following requirements:
# -1. There should be 10 Doctors with unique names
# -2. Each doctor should have 10 patients with unique names
# -3. Each patient should have 10 appointments (5 in the past, 5 in the future)
#   -3.5 Each appointment should be 50 minutes in duration

# pseudocode - for every doctor/patient create a unique name using faker
# to generate unique fake data (loop through)
# utilize rand() to create random dates in time past / future, 365 days over 2 years
# within code block of doctor add patient - within code block of patient add
# separate appointment blocks

Doctor.destroy_all
Patient.destroy_all
Appointment.destroy_all

10.times do
  doctor = Doctor.create(
    name: Faker::Name.unique.name
    email: Faker::Email.unique.email

  )

  10.times do
    patient = Patient.create(
      doctor_id: doctor.id,
      name: Faker::Name.unique.name
    )

     5.times do
      Appointment.create(
        patient_id: patient.id,
        doctor_id: patient.doctor_id,
        start_time: Time.zone.now + rand( 60 * 60 * 24 * 365 * 2),
        duration_in_minutes: 50
      )
    end

    5.times do
      Appointment.create(
        patient_id: patient.id,
        doctor_id: patient.doctor_id,
        start_time: Time.zone.now - rand( 60 * 60 * 24 * 365 * 2),
        duration_in_minutes: 50
      )
      end
  end
end
