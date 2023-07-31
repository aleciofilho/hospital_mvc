class AppointmentRepository
  def initialize(attributes = {})
    @csv_file = attributes[:csv_file]
    @doctor_repository = attributes[:doctor_repository]
    @patient_repository = attributes[:patient_repository]
    @appointments = attributes[:appointments] || []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def create(appointment)
    appointment.id = @next_id
    @appointments << appointment
    save_csv
    @next_id += 1
  end

  def all
    @appointments
  end

  private 

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      csv << %i[id date doctor_id patient_id]
      @appointments.each do |appointment|
        csv << [appointment.id, appointment.date, appointment.doctor.id, appointment.patient.id]
      end
    end
  end
 
  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      id = row[:id].to_i
      
      # find a doctor based on row[:doctor_id]
      doctor = @doctor_repository.find(row[:doctor_id].to_i)
      
      # find a patient basedo on row[:patient_id]
      patient = @patient_repository.find(row[:patient_id].to_i)

      # create new appointment
      appointment = Appointment.new(id: id, date: row[:date], doctor: doctor, patient: patient)

      @appointments << appointment
    end
    @next_id = @appointments.last.id + 1 unless @appointments.empty?
  end
end