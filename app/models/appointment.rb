class Appointment
  attr_accessor :id
  attr_reader :date, :doctor, :patient

  def initialize(attributes = {})
    @id = attributes[:id]
    @date = attributes[:date]
    @doctor = attributes[:doctor]
    @patient = attributes[:patient]
  end
end