def name
  "import_shodan_xml"
end

def pretty_name
  "Import SHODAN XML"
end

## Returns a string which describes what this task does
def description
  "This is a task to import SHODAN xml."
end

## Returns an array of types that are allowed to call this task
def allowed_types
  [Tapir::Entities::ParsableFile]
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

  # Create our parser
  xml = Tapir::Import::ShodanXml.new
  parser = Nokogiri::XML::SAX::Parser.new(xml)
  # Send some XML to the parser
  parser.parse(File.read(@entity.path))
  
  xml.shodan_hosts.each do |shodan_host|
    #
    # Create the host / loc / domain entity for each host we know about
    #
    domain = create_entity(Tapir::Entities::Domain, {:name => shodan_host.hostnames }) if shodan_host.hostnames.kind_of? String
    host = create_entity(Tapir::Entities::Host, {:ip_address => shodan_host.ip_address })
    loc = create_entity(Tapir::Entities::PhysicalLocation, {:city => shodan_host.city, :country => shodan_host.country})

    shodan_host.services.each do |shodan_service|
      #
      # Create the service and associate it with our host above
      #
      create_entity(Tapir::Entities::NetSvc, {
        :port_num => shodan_service.port,
        :type => "tcp",
        :fingerprint => shodan_service.data })
    end # End services processing

  end # End host processing
  
end

def cleanup
  super
end
