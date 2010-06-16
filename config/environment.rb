# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.8' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')


APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/gat.yml")[RAILS_ENV]

Rails::Initializer.run do |config|
  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )     wa
  config.gem "RedCloth"
  config.gem "haml"
  config.gem "searchlogic"
  config.gem "json"
  config.gem "oauth2"
  config.gem "will_paginate", :version => '~> 2.3.12'
  config.time_zone = 'UTC'

  config.i18n.default_locale = :en

  config.action_mailer.default_url_options = { :host => APP_CONFIG["app_domain"] }
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    :enable_starttls_auto => true,
    :address        => 'smtp.gmail.com',
    :port           => 587,
    :domain         => 'www.giveawaythings.org',
    :authentication => :plain,
    :user_name      => 'no-reply@giveawaythings.org',
    :password       => 'smtp55!@'
  }
    
  
end