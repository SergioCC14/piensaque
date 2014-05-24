# Convierte un string en un slug
# https://github.com/pjg/ruby_extensions/blob/master/lib/ruby_extensions.rb
def string_to_slug(str)
  return str.force_encoding('utf-8').gsub(/[-‐‒–—―⁃−­]/, '-').gsub('#', 'sharp').gsub('+', 'plus').gsub('&', 'and').unaccent.to_ascii({'ñ' => 'ñ', 'Ñ' => 'Ñ'}).downcase.gsub(/[^a-zñ0-9 ]/, ' ').strip.gsub(/[ ]+/, '-')
end