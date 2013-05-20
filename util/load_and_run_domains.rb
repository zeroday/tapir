#!/usr/bin/ruby
require "#{File.expand_path(File.dirname(__FILE__))}/../config/environment"

# open up a list of domains
f = File.open("../data/domain_top1k.list", "r")

puts "Running..."
# For each domain
f.each do |line| 
  puts "trying #{line}"
  begin 

    # create the domain entity
    d = Tapir::Entities::Domain.create :name => line.strip
  
    # Screenshot task. -- add more tasks here.
    #d.run_task "web_screenshot", { :timeout => "20" }
    #d.run_task "web_grab", { :timeout => "20" }
    #d.run_task "dns_srv_brute"

    # Print the contents of the page (from the grab task)
    #puts d.records.first.content 

    # Or by relationship
    #puts d.children.first.content
    
  rescue Exception => e
    puts "ohnoes! #{e}"
  end
end
puts "Done."
