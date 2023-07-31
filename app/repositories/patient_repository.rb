class PatientRepository
  def initialize(attributes = {})
    @csv_file = attributes[:csv_file]
    @room_repository = attributes[:room_repository]
    @patients = attributes[:patients] || []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def create(patient)
    patient.id = @next_id
    @patients << patient
    save_csv
    @next_id += 1
  end

  def all
    @patients
  end

  def find(patient_id)
    @patients.find { |patient| patient.id == patient_id }
  end

  def find_by_index(index)
    @patients[index]
  end

  private

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      csv << %i[id name cured room_id]
      @patients.each do |patient|
        csv << [patient.id, patient.name, patient.cured, patient.room.id]
      end
    end
  end
 
  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:name] = row[:name]
      row[:cured] = row[:cured] == "true"
      patient = Patient.new(row)
      room = @room_repository.find(row[:room_id].to_i)
      room.add_patient(patient)
      @patients << patient
    end
    @next_id = @patients.last.id + 1 unless @patients.empty?
  end
end