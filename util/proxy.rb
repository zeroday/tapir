#!/usr/bin/env ruby
# Blatently stolen and modified from a version by 
# Torsten Becker <torsten.becker@gmail.com>
# https://gist.github.com/torsten/74107

puts "Loading Rails environment"

require "#{File.join(File.dirname(__FILE__), "..", "config", "environment")}"
require 'webrick' 
require 'webrick/httpproxy' 

s = WEBrick::HTTPProxyServer.new(
    :Port => 8080,
    :RequestCallback => Proc.new { |req,res| 
      begin
        Mongoid::Multitenancy.current_tenant = Tapir::Tenant.all.first
        Tapir::Entities::Domain.create(:name => "#{req.host}")
        Tapir::Entities::NetSvc.create(:port_num => req.port, :proto => "tcp")
      rescue Exception => e
        puts "Exception #{e}"
      end
    }
  )

# Shutdown functionality
trap("INT"){s.shutdown}

# Go
puts "Proxytime -> localhost:8080"
s.start