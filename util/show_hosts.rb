#!/usr/bin/ruby

current_dir = File.expand_path(File.dirname(__FILE__))
require "#{current_dir}/../config/environment"

# add in a lookup
Tapir::Entities::Host.all.each do |h|
    puts h
    puts "  #{h.task_runs}"
    puts "  #{Tapir::TaskRun.find_by_parent_id(h.id)}"
end

puts "Done."
