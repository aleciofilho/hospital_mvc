require "csv"
require_relative "./app/models/room"
require_relative "./app/models/patient"
require_relative "./app/models/doctor"
require_relative "./app/models/appointment"
require_relative "./app/repositories/patient_repository"
require_relative "./app/repositories/room_repository"
require_relative "./app/repositories/doctor_repository"
require_relative "./app/repositories/appointment_repository"
require_relative "./app/controllers/patients_controller"
require_relative "./app/controllers/rooms_controller"
require_relative "./app/controllers/appointments_controller"
require_relative "./app/views/patient_view"
require_relative "./app/views/room_view"
require_relative "./app/views/doctor_view"
require_relative "./app/views/appointment_view"

room_repository = RoomRepository.new(csv_file: "./data/rooms.csv")
patient_repository = PatientRepository.new(csv_file: "./data/patients.csv", room_repository: room_repository)
doctor_repository = DoctorRepository.new(csv_file: "./data/doctors.csv")
appointment_repository = AppointmentRepository.new(csv_file: "./data/appointments.csv", doctor_repository: doctor_repository, patient_repository: patient_repository)
rooms_controller = RoomsController.new(room_repository: room_repository)
patients_controller = PatientsController.new(patient_repository: patient_repository, room_repository: room_repository)
appointments_controller = AppointmentsController.new(appointment_repository: appointment_repository, doctor_repository: doctor_repository, patient_repository: patient_repository)

# to create a room, do it manually like this:
# 1. instantiate a room
# room = Room.new(number: 52, capacity: 2)
# room2 = Room.new(number: 34, capacity: 3)
# 2. add it to the repository (and .csv)
# room_repository.create(room)
# room_repository.create(room2)
# to list all rooms, run:
# rooms_controller.list

# to create a patient, first create at least a room, then run:
# patients_controller.add

# to create doctors, do it manually like this:
# 1. isntantiate a doctor 
# doctor = Doctor.new(name: "Dr. House")
# doctor_d = Doctor.new(name: "Dr. Doom")
# 2. add it to the repository (and .csv)
# doctor_repository.create(doctor)
# doctor_repository.create(doctor_d)

# to create an appointments, first create at least a patient and a doctor, then run:
# appointments_controller.add
# to list appointments run:
# appointments_controller.list
