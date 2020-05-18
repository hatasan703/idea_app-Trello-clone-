class MessagesController < ApplicationController

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
      redirect_to "/rooms/#{@message.room_id}"
      sending_user = Room.find(params[:message][:room_id]).entries.where.not(user_id: current_user.id).first.user
      MessageMailer.send_message_notification(sending_user, current_user, @message).deliver
    else
      redirect_back(fallback_location: root_path)
    end
  end

end
