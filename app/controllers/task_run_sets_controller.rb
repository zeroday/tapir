class TaskRunSetsController < ApplicationController
  # GET /task_run_sets
  # GET /task_run_sets.json
  def index
    @task_run_sets = Tapir::TaskRunSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @task_run_sets }
    end
  end

  # GET /task_run_sets/1
  # GET /task_run_sets/1.json
  def show
    @task_run_set = Tapir::TaskRunSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task_run_set }
    end
  end

  # GET /task_run_sets/new
  # GET /task_run_sets/new.json
  def new
    @task_run_set = Tapir::TaskRunSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task_run_set }
    end
  end

  # GET /task_run_sets/1/edit
  def edit
    @task_run_set = Tapir::TaskRunSet.find(params[:id])
  end

  # POST /task_run_sets
  # POST /task_run_sets.json
  def create
    @task_run_set = Tapir::TaskRunSet.new(params[:tapir_task_set])

    respond_to do |format|
      if @task_run_set.save
        format.html { redirect_to @task_run_set, notice: 'Task set was successfully created.' }
        format.json { render json: @task_run_set, status: :created, location: @task_run_set }
      else
        format.html { render action: "new" }
        format.json { render json: @task_run_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /task_run_sets/1
  # PUT /task_run_sets/1.json
  def update
    @task_run_set = Tapir::TaskRunSet.find(params[:id])

    respond_to do |format|
      if @task_run_set.update_attributes(params[:tapir_task_set])
        format.html { redirect_to @task_run_set, notice: 'Task set was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task_run_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /task_run_sets/1
  # DELETE /task_run_sets/1.json
  def destroy
    @task_run_set = Tapir::TaskRunSet.find(params[:id])
    @task_run_set.destroy

    respond_to do |format|
      format.html { redirect_to task_run_sets_url }
      format.json { head :no_content }
    end
  end
  
  def run
    #
    # Get our params
    #
    entity_set = params[:entities]
    task_name = params[:task_name]
    options = params[:options] || {}
    task_run_set = Tapir::TaskRunSet.create
    
    #
    # If we don't have reasonable input, return
    #
    # TODO - this is currently broken - how to send back to the 
    # previous page?
    redirect_to :action => "show" unless task_name
    redirect_to :action => "show" unless entity_set

    #
    # Create the entities based on the params
    #
    entities = []
    entity_set.each do |key, value|

        # Convert the parameter to a class and create an object
        # 
        # Example: 
        #  - entity_set - {"Tapir::Entities::Domain#5143ddc9ad19763c1d000004"=>"on"}
        #  - entity.titleize.gsub(" ","").gsub("/","::") - "Tapir::Entities::Domain"
        #
        entity_type = key.split("#").first
        entity_id = key.split("#").last

        type = eval(entity_type)
        entities << type.find(entity_id)
    end

    #
    # Run the task on each entity
    #
    entities.each do |o|
      # and run the task  
      o.run_task(task_name, task_run_set.id, options)
    end
    
     redirect_to :action => "show", :id => task_run_set.id
  end
  
end
