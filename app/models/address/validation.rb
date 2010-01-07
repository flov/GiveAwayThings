class Address

  validates_presence_of :city, :street
  validates_format_of   :country, :with => /../i
end