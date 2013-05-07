def name
  "built_with"
end

def pretty_name
  "Built With"
end

## Returns a string which describes what this task does
def description
  "This task grabs the www record and determines technologies"
end

## Returns an array of types that are allowed to call this task
def allowed_types
  [ Tapir::Entities::Domain, 
    Tapir::Entities::Host]
end

def setup(entity, options={})
  super(entity, options)

  if @entity.kind_of? Tapir::Entities::Host
    url = "http://#{@entity.ip_address}"
  else
    url = "http://#{@entity.name}"
  end

    @task_logger.log "Connecting to #{url} for #{@entity}" 

    begin

      status = Timeout.timeout(10) do
        # Prevent encoding errors
        contents = open("#{url}").read.force_encoding('UTF-8')

        if contents =~ /[W|w]ordpress/
          create_entity(Tapir::Entities::Finding, {:name => "Wordpress Finding", :content => "Found Wordpress"})
        end

        if contents =~ /[D|d]rupal/
          create_entity(Tapir::Entities::Finding, {:name => "Drupal Finding", :content => "Found Drupal"})
        end

        if contents =~ /javascript/
          create_entity(Tapir::Entities::Finding, {:name => "Javascript Finding", :content => "Found Javascript"})
        end

        if contents =~ /urchin.js/
          create_entity(Tapir::Entities::Finding, {:name => "Google Analytics Finding", :content => "Found Google Analytics"})
        end

        if contents =~ /optimizely/
          create_entity(Tapir::Entities::Finding, {:name => "Optimizely Finding", :content => "Found Optimizely"})
        end

        if contents =~ /trackalyze/
          create_entity(Tapir::Entities::Finding, {:name => "Trackalyze Finding", :content => "Found Trackalyze"})
        end

        if contents =~ /munchkin.js/
          create_entity(Tapir::Entities::Finding, {:name => "Marketo Finding", :content => "Found Marketo"})
        end

        if contents =~ /doubleclick.net|googleadservices/
          create_entity(Tapir::Entities::Finding, {:name => "Google Ads Finding", :content => "Found Google Ads"})
        end

      end

    rescue Timeout::Error
      @task_logger.log "Timeout!"
    rescue OpenURI::HTTPError => e
      @task_logger.log "Unable to connect: #{e}"
    rescue Net::HTTPBadResponse => e
      @task_logger.log "Unable to connect: #{e}"
    rescue EOFError => e
      @task_logger.log "Unable to connect: #{e}"
    rescue SocketError => e
      @task_logger.log "Unable to connect: #{e}"
    rescue RuntimeError => e
      @task_logger.log "Unable to connect: #{e}"
    rescue SystemCallError => e
      @task_logger.log "Unable to connect: #{e}"
    rescue ArgumentError => e
      @task_logger.log "Argument Error #{e}"
    rescue Encoding::InvalidByteSequenceError => e
      @task_logger.log "Encoding error: #{e}"
    rescue Encoding::UndefinedConversionError => e
      @task_logger.log "Encoding error: #{e}"
    end

end

## Default method, subclasses must override this
def run
  super
end

def cleanup
  super
end
