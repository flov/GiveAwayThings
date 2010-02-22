class Request < ActiveRecord::Base
  belongs_to :person
  belongs_to :item
  has_one    :message
  
  accepts_nested_attributes_for :message
  
  validates_presence_of :person_id, :item_id
  validates_uniqueness_of [:person_id, :item_id], :on => :create, :message => "must be unique"
end