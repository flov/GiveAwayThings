Factory.define :user, :class => 'user' do |user|
  user.login 'flov'
  user.email 'user@fuckingawesome.com'
  user.first_name 'User'
  user.last_name 'Experience'
  user.password 'makeabarrier'
  user.password_confirmation 'makeabarrier'
end
