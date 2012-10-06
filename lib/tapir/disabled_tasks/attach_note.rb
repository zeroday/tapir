def name
  "attach_note"
end

#
# Returns a string which describes what this task does
#
def description
  "This task simply attaches a note entity to the current entity."
end

#
# Returns an array of types that are allowed to call this task
#
def allowed_types
  [ Tapir::Entities::Domain, 
    Tapir::Entities::Host, 
    Tapir::Entities::Organization, 
    Tapir::Entities::User]
end

def setup(entity, options={})
  super(entity, options)
end

def run
  super
  #
  # Create the attached note entity
  # 
  x = create_entity Note, { :name => @options[:name], :description => @options[:description] }
end

def cleanup
  super
end
