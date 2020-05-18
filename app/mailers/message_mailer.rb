class MessageMailer < ApplicationMailer
  
  def send_message_notification(user, sender, message) #メソッドに対して引数を設定
    @user = user #ユーザー情報
    @sender = sender
    @message = message
    @room_id = message.room_id
    mail to: user.email, subject: "【probo】 #{sender.name}さんからダイレクトメッセージが届いています。"
  end

end
