class EntitiesController < ApplicationController

  # GET /tapir/entities
  # GET /tapir/entities.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: EntitiesDatatable.new(view_context) }
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
    @entity_types = _get_valid_type_class_names

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /tapir/entities/1/edit
  def edit
    type = params[:type]

    # TODO - security - verify.

    @entity = eval("#{type}").find(params[:id])
  end

  # POST /tapir/tapir/entities
  # POST /tapir/tapir/entities.json
  def create

    # interpret the type based on the user's input. 
    type = params[:type]

    # Check valid entities
    @entity_types = _get_valid_type_class_names
    
    # TODO - there has to be a better way to do this
    render action: "new", notice: "invalid entity type." unless @entity_types.include?(type)

    @entity = eval("Tapir::Entities::#{type}").new

    respond_to do |format|
      if @entity.save(:validate => false)
        format.html { render action: "edit", notice: 'entity was successfully created.' }
        format.json { render json: @entity, status: :created, location: @entity }
      else
        format.html { render action: "new", notice: "unable to save entity." }
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

  private

  # Return the valid entity types
  def _get_valid_type_class_names
    Tapir::Entities::Base.descendants.map{|x| x.name.split("::").last}
  end
  
  # Return the valid entity types
  def _get_valid_types
    Tapir::Entities::Base.descendants
  end

end
