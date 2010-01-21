Factory.define(:person) do |p|
  p.sequence(:username) { |n| "flov#{n}" }
  p.sequence(:email) { |n| "foo#{n}@gmail.com" }
  p.password "makeabarrier"
  p.password_confirmation { |u| u.password }
  p.association :address  
end
