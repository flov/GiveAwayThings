class Country < ActiveRecord::Base
  has_many :cities
  
  named_scope :order_by_name, :order => :name  
  validates_presence_of :iso, :with => /../i
  validates_uniqueness_of :iso
  def <=>(other)
    name <=> other.name
  end

  def to_s
    name
  end
end