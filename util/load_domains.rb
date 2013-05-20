#!/usr/bin/env ruby
require "#{File.join(File.dirname(__FILE__), "..", "config", "environment")}"

# Set the current tenant - this is required because
# all entities must be scoped according to the tenant
Mongoid::Multitenancy.current_tenant = Tapir::Tenant.all.first

f = File.open(ARGV[0], "r")

puts "Importing..."
f.each { |line| 
	d = Tapir::Entities::Domain.create(
    :name => line.chomp,
    :tenant_id => Tapir::Tenant.all.first.id)
}
puts "Done."
