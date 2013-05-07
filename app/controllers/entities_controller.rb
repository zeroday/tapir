class EntitiesController < ApplicationController
  # GET /tapir/entities
  # GET /tapir/entities.json
  def index
    @entities = Tapir::Entities::Base.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entities }
    end
  end

  # GET /tapir/entities/1
  # GET /tapir/entities/1.json
  def show
    @entity = Tapir::Entities::Base.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /tapir/entities/new
  # GET /tapir/entities/new.json
  def new
    @entity_types = Tapir::Entities::Base.descendants.map{|x| x.name.split("::").last}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /tapir/entities/1/edit
  def edit
    type = params[:type]
    @entity = eval("#{type}").find(params[:id])
  end

  # POST /tapir/tapir/entities
  # POST /tapir/tapir/entities.json
  def create

    # interpret the type based on the user's input. 
    # TODO - SECURITY - limit this to valid type
    type = params[:type]
    @entity = eval("Tapir::Entities::#{type}").new

    respond_to do |format|
      if @entity.save
        format.html { render action: "edit", notice: 'entity was successfully created.' }
        format.json { render json: @entity, status: :created, location: @entity }
      else
        format.html { render action: "new" }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tapir/entities/1
  # PUT /tapir/entities/1.json
  def update
    type = params[:type]
    @entity = eval("#{type}").find(params[:oid])
    respond_to do |format|
      if @entity.update_attributes(params)
        format.html { redirect_to tapir_entity_path(@entity), notice: 'Entity was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tapir/entities/1
  # DELETE /tapir/entities/1.json
  def destroy
    type = params[:type]
    @entity = eval("#{type}").find(params[:id])
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to tapir_entities_url }
      format.json { head :ok }
    end
  end
end
