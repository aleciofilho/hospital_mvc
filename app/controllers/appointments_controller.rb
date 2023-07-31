class AppointmentsController
  def initialize(attributes = {})
    @appointment_repository = attributes[:appointment_repository]
    @view = AppointmentView.new
    @doctor_repository = attributes[:doctor_repository]
    @doctor_view = DoctorView.new
    @patient_repository = attributes[:patient_repository]
    @patient_view = PatientView.new
  end

  def add
    date = @view.ask_date
    @doctor_view.display_all(@doctor_repository.all)
    doctor_index = @view.ask_index
    doctor = @doctor_repository.find_by_index(doctor_index)

    @patient_view.display_all(@patient_repository.all)
    patient_index = @view.ask_index
    patient = @patient_repository.find_by_index(patient_index)

    appointment = Appointment.new(date: date, doctor: doctor, patient: patient)
    @appointment_repository.create(appointment)
  end

  def list
    appointments = @appointment_repository.all
    @view.display_all(appointments)
  end
end