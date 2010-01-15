class City < ActiveRecord::Base
  belongs_to  :country
  has_many :addresses
  
  named_scope :order_by_name, :order => :name

  validates_presence_of :name, :country

  def country_atributes=(country_atributes)
    country = Country.find(:first, :conditions=>{:iso=>country_atributes["iso"]})
    puts country.id unless country.nil?
  end
  
  def <=>(other)
    name <=> other.name
  end

  def to_s
    name
  end
end