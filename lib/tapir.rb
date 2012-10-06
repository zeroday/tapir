require 'open-uri'
require 'cgi'
require 'nmap/parser'
require 'rex'
require 'nokogiri'
require 'mongoid'
require 'yaml'

#
# Configure the path to all tapir backend files
#
$:.unshift(File.join(File.expand_path(File.dirname(__FILE__))))

#
# CLIENT
#
require 'tapir/client/social'

#
# Individual service clients
#
service_client_dir = File.join(File.expand_path(File.dirname(__FILE__)),"tapir", "client","services")
Dir[service_client_dir + "/" + "*.rb"].each do |file|
  require file
end

#
# CORE
#
core_dir = File.join(File.expand_path(File.dirname(__FILE__)),"tapir","core")
Dir[core_dir + "/" + "*.rb"].each do |file|
  require file
end

#
# IMPORT(ERS)
#
require 'tapir/import/shodan_xml'

#
# MODELS
#
model_dir = File.join(File.expand_path(File.dirname(__FILE__)),"tapir","models")
Dir[model_dir + "/" + "*.rb"].each do |file|
  require file
end

#
# ENTITIES
#
require 'tapir/models/entities/base'
model_dir = File.join(File.expand_path(File.dirname(__FILE__)),"tapir","models", "entities")
Dir[model_dir + "/" + "*.rb"].each do |file|
  require file
end

#
# TASKS
#
task_dir = File.join(File.expand_path(File.dirname(__FILE__)),"tapir","tasks")
Dir[task_dir + "/" + "*.rb"].each do |file|
  require file
end





