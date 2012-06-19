$:.unshift(File.dirname(__FILE__))

#
# Individual tests
#
test_dir = File.join(File.expand_path(File.dirname(__FILE__)),"test")
Dir[test_dir + "/" + "*.rb"].each do |file|
  require file
end

