class RoomView
  def display_all(rooms)
    rooms.each_with_index do |room, i|
      puts "#{i + 1}. Room #{room.number} | Capacity: #{room.patients.size}/#{room.capacity}"
    end
  end
end