Factory.sequence :login do |n|
  "gandhi_#{n}"
end

Factory.sequence :email do |n|
  "gandhi_#{n}@localhost.com"
end


# Factory.define :person do |person|
#   person.login { Factory.next(:login) }
#   person.email { Factory.next(:email) }
#   person.password 'dragons'
#   person.password_confirmation 'dragons'
# end

Factory.define :flov, :class => 'person' do |person|
  person.username 'username'
  person.email 'user@fuckingawesome.com'
  person.password 'makeabarrier'
  person.password_confirmation 'makeabarrier'
  person.city 'Duisburg'
  person.country 'Germany'
  person.street 'Darwinstr 50'
end
