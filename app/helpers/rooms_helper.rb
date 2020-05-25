module RoomsHelper
  def room_user_name(room)
    room.entries.map {|ent| ent.user unless ent.user==current_user }.first.name 
  end
end
