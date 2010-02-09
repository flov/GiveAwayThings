class Address < ActiveRecord::Base

  attr_accessible :street, :city, :city_attributes, :state, :city_id

  has_one :person
  belongs_to :city
  has_many :items
  
  accepts_nested_attributes_for :city
  

  validates_presence_of :street
  def country
    self.city.country
  end
  
  def before_save
    self.street = self.street.capitalize
  end

  def city_attributes=(city_attributes)
    self.city = City.find_or_create_by_name_and_country_id(city_attributes)
  end
end
