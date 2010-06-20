class Address < ActiveRecord::Base

  attr_accessible :street, :city, :country, :continent, :state, :lat, :lng, :street

  has_one :person
  has_many :items
  
  
  def before_save
    self.street = self.street.capitalize
  end

  def city_attributes=(city_attributes)
    self.city = City.find_or_create_by_name_and_country_id(city_attributes)
  end
end
