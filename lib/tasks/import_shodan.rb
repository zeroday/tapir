def name
  "import_shodan_xml"
end

## Returns a string which describes what this task does
def description
  "This is a task to import SHODAN xml."
end

## Returns an array of types that are allowed to call this task
def allowed_types
  [ParsableFile]
end

def setup(object, options={})
  super(object, options)
end

## Default method, subclasses must override this
def run
  super

  # Create our parser
  parser = Nokogiri::XML::SAX::Parser.new(ShodanXml.new)

  # Send some XML to the parser
  parser.parse(File.read(@object.path))
  
end

def cleanup
  super
end
