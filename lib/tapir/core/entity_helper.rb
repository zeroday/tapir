module Tapir
module Entities
module EntityHelper

  def self.included(base)
    base.class_eval do
      
      #
      # gangster method_missing magic to automatically create tasks by name
      #
=begin
      def method_missing(method, *args, &block)
         
         # Deal with the missing path helpers 
         #if method_missing =~ /tapir_entities_/
         #   binding.pry
         #   return "/entities/#{self.id}"
         #end

         # Deal with calling tasks as a method on the entity
         call_parent = true
         TaskManager.instance.get_tasks_for(self).each do |task|
          puts "checking task #{task}"
          
          #
          # Match the called method to our task names. LOL - don't 
          # regex this unless you want tasks being called at ~arb 
          # times
          #
          if method == task.name #Regexp.new(task.name)
            #
            # Run the task, and mark calling super as unnecessary.
            #
            task_arguments = args.first || {}
            self.run_task task.name, task_arguments
            call_parent = false

            # Define this method, so we don't have to check again
            # this is like caching the method missing. Should take 
            # care of a respond_to? call as well. See:
            # http://www.alfajango.com/blog/method_missing-a-rubyists-beautiful-mistress/
            self.class.send(:define_method, task.name, *args) do
              self.run_task task.name, args.first || {}
              call_parent = false
            end
          end
        end
        super if call_parent
      end
=end
      # end method_missing magic

      def to_s
        "#{self.class} #{self.name}"
      end
      
      # Class method to convert to a path
      def self.path
        self.class.to_s.downcase.gsub("::","/")
      end

      # Class method to convert to a path
      def self.underscore
        self.class.to_s.downcase.gsub("::","_")
      end

      # Instance method to convert to a path
      def path
        self.class.to_s.downcase.gsub("::","/")
      end

      # Instance method to convert to a path
      def underscore
        self.class.to_s.downcase.gsub("::","_")
      end

      def entity_type
        self.class.to_s.downcase.split("::").last
      end
 
      def underscore
        ActiveSupport::Inflector.underscore self.class
      end
      
      #
      # This method lets you query the available tasks for this entity type
      #
      def tasks
        TapirLogger.instance.log "Getting tasks for #{self}"
        TaskManager.instance.get_tasks_for(self)
      end

      #
      # This method lets you run a task on this entity
      #
      def run_task(task_name, task_run_set_id, options={})
        TapirLogger.instance.log "Asking task manager to queue task #{task_name} run on #{self} with options: #{options} - part of taskrun set: #{task_run_set_id}"
        TaskManager.instance.queue_task_run(task_name, task_run_set_id, self, options)
      end

      #
      # This method lets you find all available children
      #
      def children
        TapirLogger.instance.log "Finding children for #{self}"
        EntityManager.instance.find_children(self.id, self.class.to_s)
      end

      #
      # This method lets you find all available parents
      #
      def parents
        TapirLogger.instance.log "Finding parents for #{self}"
        EntityManager.instance.find_parents(self.id, self.class.to_s)
      end

      #
      # This method lets you find all available parents
      #
      def parent_tasks
        TapirLogger.instance.log "Finding task runs for #{self}"
        EntityManager.instance.find_task_runs(self.id, self.class.to_s)
      end
      
      def task_runs
        TapirLogger.instance.log "Finding task runs for #{self}"
        EntityManager.instance.find_task_runs(self.id, self.class.to_s)
      end
      #
      # This method associates a child with this entity
      #
      def associate_child(params)
        # Pull out the relevant parameters
        new_entity = params[:child]
        task_run = params[:task_run]

        # grab the entity's class
        class_name = new_entity.class.to_s.downcase
        
        # And set us up as a parent through an entity_mapping
        # new_entity._map_parent(params)  
         # And associate the entity as a child through an entity mapping
        TapirLogger.instance.log "Associating #{self} with child entity #{new_entity}"
        _map_child(params)
      end
      
      # 
      # This method returns a pretty print version of the relationships
      #  of this entity
      # 
      def to_graph(indent=nil)
        out = "Parents:\n"
        self.parents.each { |parent| out << " #{parent}" }
        out << "\Entity: #{self.to_s}\n"
        out << "Children:\n"
        self.children.each { |child| out << " #{child}" }
        out
      end

      def _map_child(params)
        TapirLogger.instance.log "Creating new child mapping #{self} => #{params[:child]}"
        EntityMapping.create(
          :parent_id => self.id,
          :parent_type => self.class.to_s,
          :child_id => params[:child].id,
          :child_type => params[:child].class.to_s,
          :task_run_id => params[:task_run].id || nil)
      end
    end
  end
end
end
end
