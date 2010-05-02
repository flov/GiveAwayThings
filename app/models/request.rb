class Request < ActiveRecord::Base
  belongs_to :owner, :class_name => "Person"
  belongs_to :requester, :class_name => "Person"
  belongs_to :item
  has_one :message
  accepts_nested_attributes_for :message

  validates_presence_of :requester_id, :item_id
  validates_uniqueness_of :requester_id, :scope => :item_id, :on => :create, :message => "must be unique"
  
  named_scope :archived,    :conditions => { :archived => true  }
  named_scope :unarchived,  :conditions => { :archived => false }
  
  def owners_reference(person)
    self.owner.references.from_id_equals(person).first
  end
  
  def mark_item_as_taken(taken_by)
    self.item.update_attribute(:taken_by, Person.find(taken_by)) unless taken_by.empty?
  end
  
  def archive_request
    self.update_attribute(:archived, true)
  end
end