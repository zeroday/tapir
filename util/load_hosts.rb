#!/usr/bin/ruby

current_dir = File.expand_path(File.dirname(__FILE__))
require "#{current_dir}/../config/environment"

# open up a list of domains
f = File.open(ARGV[0], "r")

puts "Running..."
f.each do |line| 
  begin 
    h = Tapir::Entities::Host.create :ip_address => line.strip
  rescue Exception => e
    puts "ohnoes! #{e}"
  end
end
