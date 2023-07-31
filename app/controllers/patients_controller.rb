class PatientsController
  def initialize(attributes = {})
    @patient_repository = attributes[:patient_repository]
    @view = PatientView.new
    @room_repository = attributes[:room_repository]
    @room_view = RoomView.new
  end

  def add
    name = @view.ask_name
    @room_view.display_all(@room_repository.all)
    index = @view.ask_index
    room = @room_repository.find_by_index(index)
    patient = Patient.new(name: name)
    room.add_patient(patient)
    @patient_repository.create(patient)
  end
end