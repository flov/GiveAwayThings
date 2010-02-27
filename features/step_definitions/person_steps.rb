Given /^I am currently "([^\"]*)"$/ do |login|
  @current_user ||= Person.find_by_username(login) || Factory(login.to_sym)
  @user = @current_user
end