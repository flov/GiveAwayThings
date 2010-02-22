class Message < ActiveRecord::Base
  belongs_to :request
  belongs_to :person
  
end
