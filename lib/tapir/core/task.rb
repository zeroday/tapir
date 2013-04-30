module Tapir
class Task

  # Rails model compatibility #
  def self.all
    TaskManager.instance.create_all_tasks
  end

  def self.find(name)
    TaskManager.instance.create_by_name name
  end

  def self.find_by_name(name)
    TaskManager.instance.create_by_name name
  end
  
  def self.model_name
    "task"
  end 

  def self.id
    return self.name
  end
  # End Rails compatibility #
 
  attr_accessor :task_logger
  attr_accessor :task_run

  def candidates
    candidate_list = []
    Tapir::Entities::Base.all.each do |entity| 
      candidate_list << entity if self.allowed_types.include? entity.class
    end
  candidate_list
  end

  def underscore
    "task"
  end

  def full_path
    __FILE__
  end

  def allowed_types
    []
  end

  def name
    "Generic Task"
  end
  
  def task_name
    name
  end

  def pretty_name
    "Generic Task"
  end
  
  def description
    "This is a generic task"
  end

  #
  # Override me
  #
  def setup(entity, options={})
    
    @entity = entity # the entity we're operating on
    @options = options # the options for this task
    @results = [] # temporary collection of all created entitys

    # Create a task run for each one of our entitys
    @task_run = TaskRun.create :task_name => self.name, 
      :task_entity_id => @entity.id,
      :task_entity_type => @entity.class.to_s,
      :task_options_hash => @options

    @task_logger = TaskLogger.new(@task_run.id, self.name, true)
     
    #
    # Do a little logging. do it for the kids.
    #
    @task_logger.log "Setup called."
    @task_logger.log "Task entity: #{@entity}"
    @task_logger.log "Task options: #{@options.inspect}"
  end
  
  #
  # Override me
  #
  def run
  end
  
  #
  # Override me baby
  #
  def cleanup
    @task_logger.log "Cleanup called." 
  end
  
  def to_s
    "#{name}: #{description}"
  end

  #
  # Convenience Method - do not override
  #
  def safe_system(command)
    @task_logger.log_error "UNSAFE SYSTEM CALL. NOT COOL."
  
    if command =~ /(\||\;)/
      raise "Illegal character"
    end

    `#{command}`
  end

  #
  # Convenience method that makes it easy to create
  # entitys from within a task. designed to simplify the 
  # task api. do not override.
  #
  # current_entity keeps track of the current entity which we're associating with
  # params are params for creating the new entity
  #  new_entity keeps track of the new entity
  #
  def create_entity(type, params, current_entity=@entity)
    @task_logger.log "Attempting to create new entity of type: #{type}"

    #
    # Call the create method for this type
    #
    new_entity = type.send(:create, params)

    #
    # Check for dupes & return right away if this doesn't save a new
    # entity. This should prevent the entity mapping from getting created.
    #    
    if new_entity.save
      @task_logger.log_good "Created new entity: #{new_entity}"
    else
      @task_logger.log "Could not save entity, are you sure it's valid & doesn't already exist?"
      new_entity = find_entity type, params
    end
    
    #
    # If we have a new entity, then we should keep track of the information
    # that created this entity
    #
    # TODO - this currently prevents entities from being mapped as children twice (with different task runs)
    # this might not be desired behavior in some cases
    #
    if current_entity.children.include? new_entity
      @task_logger.log "Skipping association of #{current_entity} and #{new_entity}. It's already a child."
    else
      @task_logger.log "Associating #{current_entity} with #{new_entity} and task run #{@task_run}"
      current_entity.associate_child({:child => new_entity, :task_run => @task_run}) 
    end
    
  new_entity
  end

  #
  # This method is used to locate a pre-existing entity before we try to save a new 
  # entity. It is called by create_entity in the Task class. The params entity is a 
  # set of things that will be used to create the entity, so it's generally safe to 
  # refer to the most common of parameters for the entity (especially if they're 
  # enforced by validation)
  #
  # takes a type, and a set of params
  #
  # returns the entity if it is found, else false
  #
  # Will raise an error if it doesn't know how to find a type of entity
  #
  # ooh, this is dangerous metamagic. -- would need to be revisited if we do 
  # something weird with the models. for now, it should be sufficent to generally
  # send "name" and special case anything else.
  #
  def find_entity(type, params)
    if type == Host
      return Tapir::Entities::Host.find_by_ip_address params[:ip_address]
    elsif type == Account
      return Tapir::Entities::Account.find_by_account_name_and_service_name params[:account_name],params[:service_name]
    elsif type == NetBlock
      return Tapir::Entities::NetBlock.find_by_range params[:range]
    elsif type == NetSvc
      return Tapir::Entities::NetSvc.find_by_host_and_port_num parasm[:host],params[:port_num]
    elsif type == ParsableFile
      return Tapir::Entities::ParsableFile.find_by_path params[:path]
    else
      if params.has_key? :name
        return type.send(:find_by_name, params[:name])
        else
        raise "Don't know how to find this entity of type #{type}"
      end
    end
  end

  # 
  # Run the task. Convenience method. Do not override
  #
  def execute(entity, options={}, task_run_set_id)
    
    #
    # Do some logging in the main Tapir log
    # 
    TapirLogger.instance.log "Running task: #{self.name}"
    TapirLogger.instance.log "entity: #{entity}"
    TapirLogger.instance.log "Options: #{options}"

    #
    # Call the methods to actually do something with the entitys that have
    # been passed into this task
    #
    self.setup(entity, options)
    
    #
    # UGH. This is so we can keep track of which tasks were run together.
    #
    TapirLogger.instance.log "Associating task run #{@task_run} with set #{task_run_set_id}"
    @task_run.task_run_set_id = task_run_set_id
    @task_run.save
    
    self.run
    self.cleanup 
    
    #
    # Record results in the task_run
    #
    @task_logger.log "Recording results"
    
    #
    # Mark complete in the task log
    #
    @task_logger.log "done recording"
    # End recording of results
    
    #
    # return the log
    #
    @task_run.task_log = @task_logger.text
    @task_run.save
  end
  
end
end