class Message < ActiveRecord::Base
  belongs_to :request
  belongs_to :recipient, :class_name => "Person"
  belongs_to :author, :class_name => "Person"
end
