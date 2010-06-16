class AppLink < ActiveRecord::Base

  belongs_to :person
  validates_uniqueness_of :app_user_id, :scope => :provider
  validates_uniqueness_of :person_id, :scope => :provider
  validates_presence_of   :app_user_id

  def self.providers
    APP_CONFIG['oauth_providers'].collect { |key,provider| provider['name'] }
  end
end