class Item < ActiveRecord::Base

  cattr_reader :per_page
  @@per_page = 20
  
  belongs_to :person
  belongs_to :taken_by, :class_name => "Person", :foreign_key => "taken_by"
  belongs_to :address
  belongs_to :category
  has_many :requests
  has_attached_file :photo

  accepts_nested_attributes_for :category
  concerned_with :validation

  named_scope :unread,  :conditions => { :read => 0, :request_id => nil }
  
  def not_accepted
    self.requests
  end

  def self.search_by_city(search, page)
    Item.address_city_name_like(search).paginate(:page => page)
  end

  def self.search_by_title(search, page)
    Item.title_like(search).paginate(:page => page)
  end

  def city
    self.address.city.name
  end
  
  def country
    self.address.city.country
  end

  def to_param
    "#{id}-#{title.downcase.gsub(/[^[:alnum:]]/,'-')}".gsub(/-{2,}/,'-')
  end

  def before_save
    if self.title == 'Type in item.' or self.title == "Come on. Think of something to give away..."
      self.title = ""
    end
    if self.description == 'Description (optional)'
      self.description = ""
    end
  end
end
