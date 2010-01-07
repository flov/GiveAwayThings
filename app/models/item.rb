class Item < ActiveRecord::Base

  belongs_to :person
  belongs_to :address

  concerned_with :validation
  
end
