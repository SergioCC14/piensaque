class ApplicationMailer < ActionMailer::Base
  default from: "piensaque.com@gmail.com"


  # Mail de bienvenida para los que pidieron invitación
  def welcome_mail_invitations(request_invitation)
    @ri = request_invitation
    @url  = PIENSAQUE_PATH + new_user_path(ri: @ri.id, tkn: @ri.token)

    mail(to: @ri.email, subject: 'Se acabaron los cafés', from: "PiensaQue <piensaque.com@gmail.com>")
  end

end
