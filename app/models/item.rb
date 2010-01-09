class Item < ActiveRecord::Base

  belongs_to :person
  belongs_to :address
  belongs_to :category

  concerned_with :validation
  def self.search(search)
    if search
      find(:all, :conditions => ["title LIKE ?", "%#{search}%"])
    else
      find(:all)
    end
  end

end
