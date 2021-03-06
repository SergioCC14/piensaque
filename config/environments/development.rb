  # # Gestión de Errores por Mail
  # PiensaQue::Application.config.middleware.use ExceptionNotification::Rack,
  # :email => {
  #   :email_prefix => "[PiensaQue] ",
  #   :sender_address => %{"[PiensaQue] Production Error" <piensaque.com@gmail.com>},
  #   :exception_recipients => %w{sergiocc14.12@gmail.com}
  # }

PiensaQue::Application.configure do

  config.paperclip_defaults = {
    :path => ":rails_root/public/system/:class/:attachment/:id_partition/:style/:filename",
    :url => "http://localhost:3000/system/:class/:attachment/:id_partition/:style/:filename"
  }

  # s3.amazonaws.com/public.piensaque/

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address => ENV['SMTP_ADDRESS'],
    :authentication => :login,
    :user_name => ENV['SMTP_USERNAME'],
    :password => ENV['SMTP_PASSWORD'],
    :enable_starttls_auto => true,
    :port => 25
  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false
  config.assets.digest = false

  # Expands the lines which load the assets
  config.assets.debug = true

  # Ruta para guardar los avatares
  Paperclip.options[:command_path] = "/usr/local/bin/"

  config.eager_load = false
end