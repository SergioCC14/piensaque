class ApplicationMailer < ActionMailer::Base
  default from: "piensaque.com@gmail.com"


  # Mail de bienvenida para los que pidieron invitación
  def welcome_mail_invitations(request_invitation)
    @ri = request_invitation
    @url  = PIENSAQUE_PATH + new_user_path(ri: @ri.id, tkn: @ri.token)

    mail(to: @ri.email, subject: 'Se acabaron los cafés', from: "PiensaQue <piensaque.com@gmail.com>")
  end

  # Mal - Notificacion cuando llega un usuario
  def new_user(user)
    @user = user
    @url = PIENSAQUE_PATH + user_nick_path(@user.nick)

    mail(to: "sergiocc14.12@gmail.com", subject: "Nuevo Usuario Registrado", from: "PiensaQue <piensaque.com@gmail.com>")
  end

  # Notificacion para Administradores de nueva invitación
  def new_invitation(invitation)
    @invitation = invitation

    mail(to: "sergiocc14.12@gmail.com", subject: "Nuevo Petición de Invitación", from: "PiensaQue <piensaque.com@gmail.com>")

  end

end
