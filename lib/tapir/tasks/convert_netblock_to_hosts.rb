require 'rex'

def name
  "convert_netblock_to_hosts"
end

def pretty_name
  "Convert Netblock to Hosts"
end

## Returns a string which describes what this task does
def description
  "This task converts a netblock into host records"
end

## Returns an array of types that are allowed to call this task
def allowed_types
  [Tapir::Entities::NetBlock]
end

## Returns an array of valid options and their description/type for this task
def allowed_options
 []
end

def setup(entity, options={})
  super(entity, options)
end

## Default method, subclasses must override this
def run
  super
  r = Rex::Socket::RangeWalker.new @entity.range
  r.each do|address|
    create_entity(Tapir::Entities::Host, {:ip_address => address})
  end
end

def cleanup
  super
end
