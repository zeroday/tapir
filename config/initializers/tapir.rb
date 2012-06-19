#
# This script simply requires all core Tapir files
#

#
# Require all core libs
#
require Rails.root + 'lib/tapir/core.rb'

#
# Require all client libs
#
require Rails.root + 'lib/tapir/client.rb'

#
# Require import libs
#
require Rails.root + 'lib/tapir/import.rb'

#
# Task Manager Setup
#
TaskManager.instance.load_tasks
