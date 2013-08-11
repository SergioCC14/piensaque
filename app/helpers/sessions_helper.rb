module SessionsHelper

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user
    # @current_user ||= User.find_by(remember_token: remember_token)
  end

  # Echate un vistazo a remember_token en el tutorial


end
