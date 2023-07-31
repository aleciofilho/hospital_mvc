class DoctorRepository
  def initialize(attributes = {})
    @csv_file = attributes[:csv_file]
    @doctors = attributes[:doctors] || []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def create(doctor)
    doctor.id = @next_id
    @doctors << doctor
    save_csv
    @next_id += 1
  end

  def all
    @doctors
  end

  def find(doctor_id)
    @doctors.find { |doctor| doctor.id == doctor_id }
  end

  def find_by_index(index)
    @doctors[index]
  end

  private 

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      csv << %i[id name]
      @doctors.each do |doctor|
        csv << [doctor.id, doctor.name]
      end
    end
  end
 
  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:name] = row[:name]
      doctor = Doctor.new(row)
      @doctors << doctor
    end
    @next_id = @doctors.last.id + 1 unless @doctors.empty?
  end
end