module UsersHelper

  # Devuelve para leer, los gustos musicales
  def pretty_tastes(user)
    taste = !user.getTastes.blank? ? "I love " + user.getTastes.join(", ") + "." : nil
    return taste
  end

end
