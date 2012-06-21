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
    x = []
    Object.all.each {|o| x << o if self.allowed_types.include? o.class }
  x
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
  
  def description
    "This is a generic task"
  end

  #
  # Override me
  #
  def setup(object, options={})
    
    @object = object # the object we're operating on
    @options = options # the options for this task
    @results = [] # temporary collection of all created objects

    # Create a task run for each one of our objects
    @task_run = TaskRun.create :task_name => self.name, 
      :task_object_id => @object.id,
      :task_object_type => @object.class.to_s,
      :task_options_hash => @options

    @task_logger = TaskLogger.new(@task_run.id, self.name, true)
     
    #
    # Do a little logging. do it for the kids.
    #
    @task_logger.log "Setup called."
    @task_logger.log "Task object: #{@object}"
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
    @task_logger.log_error "UNSAFE SYSTEM CALL DUDE."
  
    if command =~ /(\||\;)/
      raise "Illegal character"
    end

    `#{command}`
  end

  #
  # Convenience method that makes it easy to create
  # objects from within a task. designed to simplify the 
  # task api. do not override.
  #
  # current_object keeps track of the current object which we're associating with
  # params are params for creating the new object
  #  new_object keeps track of the new object
  #
  def create_object(type, params, current_object=@object)
    @task_logger.log "Attempting to create new object of type: #{type}"
    #
    # Call the create method for this type
    #
    new_object = type.send(:create, params)

    #
    # Check for dupes & return right away if this doesn't save a new
    # object. This should prevent the object mapping from getting created.
    #
    
    
    #
    # DEBUG
    #
    #binding.pry
    
    if new_object.save
      @task_logger.log_good "Created new object: #{new_object}"
    else
      @task_logger.log "Could not save object, are you sure it's valid & doesn't already exist?"
      new_object = find_object type, params
    end
    
    #
    # If we have a new object, then we should keep track of the information
    # that created this object
    #
    # TODO - this currently prevents objects from being mapped as children twice (with different task runs)
    # this might not be desired behavior in some cases
    #
    if current_object.children.include? new_object
      @task_logger.log "Skipping association of #{current_object} and #{new_object}. It's already a child."
    else
      @task_logger.log "Associating #{current_object} with #{new_object} and task run #{@task_run}"
      current_object.associate_child({:child => new_object, :task_run => @task_run}) 
    end
    
  new_object
  end

  #
  # This method is used to locate a pre-existing object before we try to save a new 
  # object. It is called by create_object in the Task class. The params object is a 
  # set of things that will be used to create the object, so it's generally safe to 
  # refer to the most common of parameters for the object (especially if they're 
  # enforced by validation)
  #
  # takes a type, and a set of params
  #
  # returns the object if it is found, else false
  #
  # Will raise an error if it doesn't know how to find a type of object
  #
  # ooh, this is dangerous metamagic. -- would need to be revisited if we do 
  # something weird with the models. for now, it should be sufficent to generally
  # send "name" and special case anything else.
  #
  def find_object(type, params)
    if type == Host
      return Host.find_by_ip_address params[:ip_address]
    elsif type == Account
      return Account.find_by_account_name_and_service_name params[:account_name],params[:service_name]
    elsif type == NetBlock
      return NetBlock.find_by_range params[:range]
    elsif type == NetSvc
      return NetSvc.find_by_host_and_port_num parasm[:host],params[:port_num]
    elsif type == ParsableFile
      return ParsableFile.find_by_path params[:path]
    else
      if params.has_key? :name
        return type.send(:find_by_name, params[:name])
        else
        raise "Don't know how to find this object of type #{type}"
      end
    end
  end

  # 
  # Run the task. Convenience method. Do not override
  #
  def execute(object, options={}, task_run_set_id)
    
    #
    # Do some logging in the main Tapir log
    # 
    TapirLogger.instance.log "Running task: #{self.name}"
    TapirLogger.instance.log "Object: #{object}"
    TapirLogger.instance.log "Options: #{options}"

    #
    # Call the methods to actually do something with the objects that have
    # been passed into this task
    #
    self.setup(object, options)
    
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
