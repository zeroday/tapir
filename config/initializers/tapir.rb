require "#{Rails.root}/lib/tapir"

#
# Task Manager Setup
#
Tapir::TaskManager.instance.load_tasks