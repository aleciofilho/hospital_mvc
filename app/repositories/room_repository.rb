class RoomRepository
  def initialize(attributes = {})
    @csv_file = attributes[:csv_file]
    @rooms = attributes[:rooms] || []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def create(room)
    room.id = @next_id
    @rooms << room
    save_csv
    @next_id += 1
  end

  def all
    @rooms
  end

  def find(room_id)
    @rooms.find { |room| room.id == room_id }
  end

  def find_by_index(index)
    @rooms[index]
  end

  private

  def save_csv
    CSV.open(@csv_file, "wb") do |csv|
      csv << %i[id number capacity]
      @rooms.each do |room|
        csv << [room.id, room.number, room.capacity]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      row[:number] = row[:number].to_i
      row[:capacity] = row[:capacity].to_i
      @rooms << Room.new(row)
    end
    @next_id = @rooms.last.id + 1 unless @rooms.empty?
  end
end