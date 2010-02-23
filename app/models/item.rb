class Item < ActiveRecord::Base
  
  belongs_to :person
  belongs_to :taken_by, :class_name => "Person", :foreign_key => "taken_by"
  belongs_to :address
  belongs_to :category
  has_many :requests
  has_attached_file :photo
  
  accepts_nested_attributes_for :category
  
  concerned_with :validation

  def country
    self.address.city.country
  end

  def after_initialize
    if self.title == 'Type in item.' or self.title == "Come on. Think of something to give away..."
      self.title = ""
    end
  end
end
