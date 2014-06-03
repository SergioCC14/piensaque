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

  # Busca entre tres usuarios (aleatoriamente) en PiensaQue y devuelve los nicks
  def some_users
    users = []
    user_ids = User.ids.sort_by{rand}[1..3]
    
    for id in user_ids
      user = User.find_by(id: id)

      users << "<a href=#{user_nick_path(user.nick)}> #{name_or_nick(user)}</a>"
    end

    return users.join(", ")
  end

  # Devuelve el nombre, si no tiene, el nick
  def name_or_nick(user, surname=false)
    value = ""

    if (!user.name.blank?)
      if !user.name.blank?
        value = (!user.surname.blank? and surname) ? "#{user.name} #{user.surname}" : user.name 
      end

    else
      value = user.nick
    end

    return value
  end

end
