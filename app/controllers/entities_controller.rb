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
    #binding.pry
    @entity = Tapir::Entities::Base.find(params[:id])

    #
    # Special case - this is serialized automatically
    #
=begin 
    if @entity.referral_whois
      @entity_referral_whois_array = YAML::load(@entity.referral_whois)
      #
      # this may still be a string
      #
      @entity_referral_whois_array = [@entity_referral_whois_array] if 
        @entity_referral_whois_array.kind_of? String
    else
      @entity_referral_whois_array = []
    end
=end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /tapir/entities/new
  # GET /tapir/entities/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /tapir/entities/1/edit
  def edit
    @entity = Tapir::Entities::Base.find(params[:id])
  end

  # POST /tapir/tapir/entities
  # POST /tapir/tapir/entities.json
  def create

    # interpret the type based on the user's input. 
    # TODO - SECURITY - limit this to valid type
    type = params[:type]

    @entity = eval("Tapir::Entities::#{type}").new

    require 'pry'
    binding.pry

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
    @entity = Tapir::Entities::Base.find(params[:id])

    respond_to do |format|
      if @entity.update_attributes(params[:entity])
        format.html { redirect_to @entity, notice: 'entity was successfully updated.' }
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
    @entity = Tapir::Entities::Base.find(params[:id])
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to tapir_entities_url }
      format.json { head :ok }
    end
  end
end
