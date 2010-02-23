class Message < ActiveRecord::Base
  belongs_to :request
  belongs_to :author, :class_name => :person_id
  
end
