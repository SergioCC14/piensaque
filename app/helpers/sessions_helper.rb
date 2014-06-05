module SessionsHelper

  # Crea la cookie para mantener la sesión y un Token para localizarla y validarla
  def iniciar_sesion(user)
    remember_token = User.new_remember_token
    
    cookies.permanent["PnQ_remember_token"] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
    cookies.delete("PnQ_remember_token")
  end

  def signed_in?
    !current_user.blank?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies["PnQ_remember_token"])
    @current_user ||= User.find_by_remember_token(remember_token)
  end

  # Comprueba si el usuario es el mismo que el usuario que navega
  def its_me?(user)
    return (signed_in? and (current_user.id == user.id))
  end

end
