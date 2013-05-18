# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

setting_keys = [ 
   {:name => "linkedin_api_key", :visibility => "user"},
   {:name => "linkedin_secret_key", :visibility => "user"},
   {:name => "linkedin_auth", :visibility => "system"},
   {:name => "bing_api", :visibility => "user"},
   {:name => "google_api", :visibility => "user"},
   {:name => "corpwatch_api", :visibility => "user"}
]

setting_keys.each do |key| 
  puts "Seeding setting: #{key[:name]}"
  Tapir::Setting.create(key)
end
