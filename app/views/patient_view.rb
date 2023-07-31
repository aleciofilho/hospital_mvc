class PatientView
  def ask_name
    puts "What is the patient name?"
    gets.chomp
  end

  def ask_index
    puts "Enter index"
    gets.chomp.to_i - 1
  end

  def display_all(patients)
    patients.each_with_index do |patient, i|
      puts "#{i + 1}. #{patient.name}"
    end
  end
end