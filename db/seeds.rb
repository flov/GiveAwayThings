# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
require 'yaml'

puts "seeding countries"
data = YAML.load_file("#{RAILS_ROOT}/db/default/countries.yml")
data.each do |key, value|
  c=Country.new(value)
  c.id = value["id"]
  puts "Inserting Country: [Name: #{c.name}, Iso: #{c.iso}]"
  c.save!
end