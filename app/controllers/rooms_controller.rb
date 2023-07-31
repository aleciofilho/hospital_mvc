class RoomsController
  def initialize(attributes = {})
    @room_repository = attributes[:room_repository]
    @view = RoomView.new
  end

  def list
    rooms = @room_repository.all
    @view.display_all(rooms)
  end
end