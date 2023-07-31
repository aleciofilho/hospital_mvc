class Room
  attr_reader :number, :capacity, :patients
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @number = attributes[:number]
    @capacity = attributes[:capacity]
    @patients = []
  end

  def full?
    @patients.size == @capacity
  end

  def add_patient(patient)
    fail Exception, "The room is full" if self.full?
    patient.room = self
    @patients << patient
  end
end