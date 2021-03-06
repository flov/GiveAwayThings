class Country < ActiveRecord::Base

  has_many :addresses
  
  named_scope :order_by_name, :order => :name    

  def <=>(other)
    name <=> other.name
  end

  def to_s
    name
  end
end