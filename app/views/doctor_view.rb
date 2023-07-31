class DoctorView
  def display_all(doctors)
    doctors.each_with_index do |doctor, i|
      puts "#{i + 1}. #{doctor.name}"
    end
  end
end