#!/usr/bin/ruby

current_dir = File.expand_path(File.dirname(__FILE__))

# make sure this file is in the root of the ear directory
require "#{current_dir}/../config/environment"

# open up a list of domains
f = File.open(ARGV[0], "r")

puts "Running..."
twitter = Ear::Client::Twitter::WebClient.new
f.each do |line| 
  begin 
    account = line.chomp!
    puts "line: #{account} - (#{twitter.account_uri_for account })"  unless twitter.check_account_exists account
  rescue Exception => e
    puts "ohnoes! #{e}"
  end
end
puts "Done."
