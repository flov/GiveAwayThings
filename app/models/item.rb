class Item < ActiveRecord::Base

  belongs_to :person
  belongs_to :address
  belongs_to :category
  has_many :requests

  concerned_with :validation

end
