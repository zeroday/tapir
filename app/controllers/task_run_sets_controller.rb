class TaskRunSetsController < ApplicationController
  # GET /task_run_sets
  # GET /task_run_sets.json
  def index
    @task_run_sets = TaskRunSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @task_run_sets }
    end
  end

  # GET /task_run_sets/1
  # GET /task_run_sets/1.json
  def show
    @task_run_set = TaskRunSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task_run_set }
    end
  end

  # GET /task_run_sets/new
  # GET /task_run_sets/new.json
  def new
    @task_run_set = TaskRunSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task_run_set }
    end
  end

  # GET /task_run_sets/1/edit
  def edit
    @task_run_set = TaskRunSet.find(params[:id])
  end

  # POST /task_run_sets
  # POST /task_run_sets.json
  def create
    @task_run_set = TaskRunSet.new(params[:task_set])

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
    @task_run_set = TaskRunSet.find(params[:id])

    respond_to do |format|
      if @task_run_set.update_attributes(params[:task_set])
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
    @task_run_set = TaskRunSet.find(params[:id])
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
    object_set = params['objects']
    task_name = params['task_name']
    options = params['options'] || {}
    task_run_set = TaskRunSet.create
    
    #
    # If we don't have reasonable input, return
    #
    # TODO - flash error?
    return unless task_name
    return unless object_set

    #
    # Create the objects based on the params
    #
    objects = []
    object_set.each do |object_and_id|
      object,id = object_and_id.first.split("#")
        x = eval(object.titleize.gsub(" ","")) ## Pretty gangster (rails) magic here
        objects << x.find(id) if x
    end

    #
    # Run the task on each object
    #
    objects.each do |o|
      # and run the task  
      o.run_task(task_name, task_run_set.id, options)
    end
    
     redirect_to :action => "show", :id => task_run_set.id
  end
  
end
