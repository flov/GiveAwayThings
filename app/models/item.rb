class Item < ActiveRecord::Base
  concerned_with :validation

  belongs_to :person
  belongs_to :address
  
end
