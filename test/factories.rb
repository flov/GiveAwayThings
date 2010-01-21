Factory.define(:address) do |p|
  p.street "Darwinstr"
  p.association :city
  p.country_id 74
end 

Factory.define(:city) do |p|
  p.name "Duisburg"
  p.country_id 74
end