class City < ActiveRecord::Base
  belongs_to  :country
  has_many :addresses
  
  named_scope :order_by_name, :order => :name

  validates_presence_of :name

  def country_atributes=(country_attributes)
    country_split=country_attributes.split("_")
    self.country = Country.find(:first, :conditions=>{:iso=>country_attribu[0]})
    build_country(country_attributes) ÷if country.nil?
  end
  
  def <=>(other)
    name <=> other.name
  end

  def to_s
    name
  end
end