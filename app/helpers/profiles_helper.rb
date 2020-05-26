module ProfilesHelper

  def user_name(entry)
    entry.room.entries.map {|ent| ent.user unless ent.user==current_user }.reject(&:blank?).first.name
  end
end
