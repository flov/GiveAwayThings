class State < ActiveRecord::Base

  attr_accessible :name, :country_id, :id
  belongs_to :country  
  validates_presence_of :name, :country_id

end
