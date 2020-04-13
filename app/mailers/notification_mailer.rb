class NotificationMailer < ActionMailer::Base
  def invite_message(user, from, subject, content, company_id)
    @user = user
    @token = user.raw_invitation_token
    invitation_link = accept_user_company_invitation_url(company_id, invitation_token: @token)
    mail(
      from: from, 
      bcc: from, 
      to: @user.email, 
      subject: subject
    ) do |format|
      format.text do
        render text: "hello"
      end
    end
  end
end