#
# This script simply requires all core EAR files
#

#
# Require all core libs
#
require Rails.root + 'lib/ear/core.rb'

#
# Require all client libs
#
require Rails.root + 'lib/ear/client.rb'

#
# Require import libs
#
require Rails.root + 'lib/ear/import.rb'

#
# Initialize the API database
#
#require Rails.root + 'lib/ear/ear_api_keys.rb'

#
# Task Manager Setup
#
TaskManager.instance.load_tasks
