#!/usr/bin/env ruby
require "#{File.join(File.dirname(__FILE__), "..", "config", "environment")}"

# Set the current tenant - this is required because
# all entities must be scoped according to the tenant
Mongoid::Multitenancy.current_tenant = Tapir::Tenant.all.first

# open up a list of domains
f = File.open(ARGV[0], "r")

puts "Running..."
f.each do |line| 
  begin 
    h = Tapir::Entities::Host.create(
      :ip_address => line.strip,
      :tenant_id => Tapir::Tenant.all.first.id)
  rescue Exception => e
    puts "ohnoes! #{e}"
  end
end
