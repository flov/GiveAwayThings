# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/gat.yml")[RAILS_ENV]

Rails::Initializer.run do |config|
  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )     wa

  
  config.gem "RedCloth"
  config.gem "haml"
  config.gem "searchlogic"
  config.time_zone = 'UTC'

  config.i18n.default_locale = :en
    
end