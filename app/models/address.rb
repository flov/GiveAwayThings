class Address < ActiveRecord::Base

  attr_accessible :street, :city, :country, :continent, :state, :latitude, :longitude

  has_one :person
  has_many :items
  after_validation :fetch_coordinates
  
  geocoded_by :location
  
  named_scope :items, :joins => :items
  named_scope :unread, :conditions => { :read => 0, :request_id => nil }
    
  def location
    [city, street, country].compact.join(', ')
  end

  def coordinates
    [latitude, longitude]
  end

  def city_attributes=(city_attributes)
    self.city = City.find_or_create_by_name_and_country_id(city_attributes)
  end
end
