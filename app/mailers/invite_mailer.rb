class InviteMailer < Devise::Mailer

  def invitation_instructions(record, token, company_id, opts={})
    @token = token
    @company_id = company_id
    devise_mail(record, record.invitation_instructions || :invitation_instructions, opts)
  end

end