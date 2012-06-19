#
# Require core files
#
core_dir = File.join(File.expand_path(File.dirname(__FILE__)),"core")
Dir[core_dir + "/" + "*.rb"].each do |file|
  require file
end
