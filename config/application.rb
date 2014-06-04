require File.expand_path('../boot', __FILE__)

require 'rails/all'
require './lib/deax.rb'

if (Rails.env == 'development')
  require './config/initializers/dev_enviroments_vars.rb'
end


if (Rails.env == "production")
  PIENSAQUE_PATH = "http://www.piensaque.com"
elsif (Rails.env == "development")
  PIENSAQUE_PATH = "http://beperk.com:3000"
end

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module PiensaQue
  class Application < Rails::Application

    config.action_mailer.delivery_method = :ses
    
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_entities_in_json = true

    # Use SQL instead of Active Record's schema dumper when creating the database.
    # This is necessary if your schema can't be completely dumped by the schema dumper,
    # like if you have constraints or database-specific column types
    # config.active_record.schema_format = :sql

    # Enable the asset pipeline
    config.assets.enabled = true
    config.assets.digest = true
    # config.assets.precompile += %w( recorderWorker.js inbound_marketing.css )

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # Precompilar Assets
    config.assets.initialize_on_precompile = false
    config.assets.compile = true
  end
end
