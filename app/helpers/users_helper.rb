module UsersHelper

  # Devuelve para leer, los gustos musicales
  def pretty_tastes(user)
    return "I love " + user.getTastes.join(", ") + "."

  end

end
