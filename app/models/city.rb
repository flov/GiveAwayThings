class City < ActiveRecord::Base

  belongs_to  :country
  has_many :addresses
  accepts_nested_attributes_for :country
  
  named_scope :order_by_name, :order => :name
  validates_presence_of :name, :country_id
  validates_uniqueness_of :name, :scope => :country_id
    
  def <=>(other)
    name <=> other.name
  end

  def to_s
    name
  end
  
  def before_save
    self.name = self.name.capitalize
  end
    
end