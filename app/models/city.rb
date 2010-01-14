class City < ActiveRecord::Base
  belongs_to  :country
  has_many :addresses
  accepts_nested_attributes_for :country
  
  named_scope :order_by_name, :order => :name

  validates_presence_of :name
  
  def <=>(other)
    name <=> other.name
  end

  def to_s
    name
  end
end