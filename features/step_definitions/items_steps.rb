Given /^I have items titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
   Item.create!(:title => title)
  end
  pending
end