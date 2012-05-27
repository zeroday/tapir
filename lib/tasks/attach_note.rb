def name
  "attach_note"
end

#
# Returns a string which describes what this task does
#
def description
  "This task simply attaches a note object to the current object."
end

#
# Returns an array of types that are allowed to call this task
#
def allowed_types
  [Domain, Host, Organization, User]
end

def setup(object, options={})
  super(object, options)
end

def run
  super
  #
  # Create the attached note object
  # 
  x = create_object Note, { :name => @options[:name], :description => @options[:description] }
end

def cleanup
  super
end
