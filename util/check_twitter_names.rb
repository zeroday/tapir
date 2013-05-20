#!/usr/bin/env ruby
puts "Loading Rails environment"
require "#{File.join(File.dirname(__FILE__), "..", "config", "environment")}"

# Set the current tenant - this is required because
# all entities must be scoped according to the tenant
Mongoid::Multitenancy.current_tenant = Tapir::Tenant.all.first

# open up a list of domains
f = File.open(ARGV[0], "r")

puts "Running..."
twitter = Tapir::Client::Twitter::WebClient.new
f.each do |line| 
  begin 
    account = line.chomp!
    puts "line: #{account} - (#{twitter.account_uri_for account })" unless twitter.check_account_exists account
  rescue Exception => e
    puts "ohnoes! #{e}"
  end
end
puts "Done."
