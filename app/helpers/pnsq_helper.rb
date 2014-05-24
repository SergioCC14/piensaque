module PnsqHelper

  # Devuelve un color dependiendo del taste
  def color(pnsq)

    color = case pnsq.taste
      when 'rock' then User::ROCK_COLOR
      when 'pop' then User::POP_COLOR
      when 'electronic' then User::ELECTRONIC_COLOR
      when 'instrumental' then User::INSTRUMENTAL_COLOR
      when 'jazz' then User::JAZZ_COLOR
      when 'country' then User::COUNTRY_COLOR
      when 'hiphop' then User::HIPHOP_COLOR
      when 'classical' then User::CLASSICAL_COLOR
      when 'dance' then User::DANCE_COLOR
      when 'heavy' then User::HEAVY_COLOR
      when 'raggae' then User::REGGAE_COLOR
      when 'funk' then User::FUNK_COLOR
      else User::DEFAULT_COLOR
    end

    return color
  end

end