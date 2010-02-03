class Newsletter < ActiveRecord::Base
  validates_uniqueness_of :mail
  validates_presence_of :mail
end
