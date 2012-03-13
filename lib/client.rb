$:.unshift(File.join(File.expand_path(File.dirname(__FILE__), "client")))

#
# Mixins
#
require 'client/social'

#
# Individual service clients
#
service_clients = File.join(File.expand_path(File.dirname(__FILE__)),"client","services")
Dir[service_clients + "/" + "*.rb"].each do |file|
  require file
end

