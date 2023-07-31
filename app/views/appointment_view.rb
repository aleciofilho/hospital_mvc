class AppointmentView
  def ask_date
    puts "Enter appointment date (dd-mm-yy):"
    gets.chomp
  end

  def ask_index
    puts "Enter index"
    gets.chomp.to_i - 1
  end

  def display_all(appointments)
    appointments.each_with_index do |appointment, i|
      puts "#{i + 1}. Doctor: #{appointment.doctor.name} | Patient: #{appointment.patient.name} at #{appointment.date}"
    end
  end
end