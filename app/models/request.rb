class Request < ActiveRecord::Base
  belongs_to :owner, :class_name => "Person"
  belongs_to :requester, :class_name => "Person"
  belongs_to :item
  has_one :message
  accepts_nested_attributes_for :message

  validates_presence_of :requester_id, :item_id
  validates_uniqueness_of :requester_id, :scope => :item_id, :on => :create, :message => "must be unique"
  

end