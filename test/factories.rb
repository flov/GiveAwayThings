Factory.define(:address) do |p|
  p.street "Darwinstr"
  p.association :city
end 

Factory.define(:city) do |p|
  p.name "Duisburg"
  p.country_id 74
end