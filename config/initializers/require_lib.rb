#
# This script simply requires all core EAR files
#
Dir[Rails.root + 'lib/ear/*.rb'].each do |file|
  require file
end

#
# Require all client libs
#
require Rails.root + 'lib/client.rb'

#
# Require import libs
#
require Rails.root + 'lib/import.rb'

#
# Initialize the API database
#
require Rails.root + 'lib/ear/ear_api_keys.rb'

#
# Task Manager Setup
#
TaskManager.instance.load_tasks
