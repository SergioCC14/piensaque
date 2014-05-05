source 'https://rubygems.org'
ruby "2.1.1"

gem 'rails', '4.0.3'

#Postgres
gem 'pg'

# Amazon Web Services SDK
gem 'aws-sdk', '1.30.1' # La necesita el paperclip para trabajar con S3

# Amazon Web Services SDK (especifico para aws-s3) NO LO USAS POR AHORA
gem 'aws-s3'

# Metadatos para una cancion MP3
gem 'ruby-mp3info', :require => 'mp3info'

# Gems used only for assets and not required
# in production environments by default.

group :production do
  gem 'rails_12factor'
end

group :assets do
  gem 'sass-rails', '~> 4.0.0'
  
  # Use CoffeeScript for .js.coffee assets and views
  gem 'coffee-rails', '~> 4.0.0'


  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# jQuery
gem 'jquery-rails'

# Para incrementar los contadores
gem 'rails_atomic_increment'

#Haml
gem "haml-rails"

#Paperclip (procesado de imagenes)
gem "paperclip", "~> 3.0"