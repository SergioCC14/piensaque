module UsersHelper

  # Devuelve para leer, los gustos musicales
  def pretty_tastes(user)
    taste = !user.getTastes.blank? ? "I love " + user.getTastes.join(", ") + "." : nil
    return taste
  end

  # Comprueba si el nick ha sido utilizado
  def checker_nick(user_nick)
    if !User.find_by_nick(user_nick).blank?
      return user_nick + (rand(Time.now.sec * Time.now.hour * Time.now.min)).to_s
    else
      return user_nick
    end
  end

end
