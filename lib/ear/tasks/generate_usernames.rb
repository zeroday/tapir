def name
  "generate_usernames"
end

## Returns a string which describes what this task does
def description
  "This task can be used to generate usernames, given a user."
end

## Returns an array of types that are allowed to call this task
def allowed_types
  [User]
end

def setup(object, options={})
  super(object, options)
end

## Default method, subclasses must override this
def run
  super

  #johndoe
  @object.usernames << "#{@object.first_name}.#{@object.last_name}"
  
  # john.doe
  @object.usernames << "#{@object.first_name}.#{@object.last_name}"

  # john_doe 
  @object.usernames << "#{@object.first_name}_#{@object.last_name}"
  
  # jdoe
  @object.usernames << "#{@object.first_name.split("").first}#{@object.last_name}"

  # doe
  @object.usernames << "#{@object.last_name}"
  
  if @object.middle_name
    #johneffingdoe
    @object.usernames << "#{@object.first_name}#{@object.middle_name}#{@object.last_name}"

    #jedoe
    @object.usernames << "#{@object.first_name.split("").first}#{@object.middle_name.split("").first}#{@object.last_name}"
  end

  # don't forget
  @object.save!
end
  
def cleanup
  super
end
