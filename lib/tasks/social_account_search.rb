def name
  "profile_search"
end

## Returns a string which describes what this task does
def description
  "This task searches for common social media profiles"
end

## Returns an array of types that are allowed to call this task
def allowed_types
  return [Organization, SearchString, User]
end

def setup(object, options={})
  super(object, options)
end

## Default method, subclasses must override this
def run
  super
end

def cleanup
  super
end
