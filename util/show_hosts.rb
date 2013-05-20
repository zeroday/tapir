#!/usr/bin/env ruby
puts "Loading Rails environment"
require "#{File.join(File.dirname(__FILE__), "..", "config", "environment")}"

# Set the current tenant - this is required because
# all entities must be scoped according to the tenant
Mongoid::Multitenancy.current_tenant = Tapir::Tenant.all.first

# add in a lookup
Tapir::Entities::Host.all.each do |h|
    puts "Name         : #{h}"
    puts "Tenant       : #{h.tenant.host}"
end

puts "Done."