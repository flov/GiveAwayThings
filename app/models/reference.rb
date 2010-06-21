class Reference < ActiveRecord::Base
  belongs_to :from, :class_name => "Person"
  belongs_to :to, :class_name => "Person"
  belongs_to :item
  
  validates_presence_of :from, :to, :rating_id
  validates_uniqueness_of :to_id, :scope => :from_id, :on => :create, :message => I18n.t('requests.create_reference.already_exists')

  # def possible_ratings
  #   ratings = {}
  #   %w{negative neutral positive}.each_with_index {|rating, index| ratings[rating] = index }
  #   ratings
  # end
  
  def rating
    %w{negative neutral positive}[rating_id]
  end
  
  def given_items
    self.to.items.taken_by_equals(self.from)
  end
  
  def taken_items
    self.from.items.taken_by_equals(self.to)
  end

  def update_reference(id, params_reference)
    Reference.find(id).update_attributes(params_reference)
  end
end
