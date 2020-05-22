module ProfilesHelper

  def room_user_name(entry)
    entry.room.entries.map {|ent| ent.user unless ent.user==current_user }.first.name 
  end
end
