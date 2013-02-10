class EntitiesController < ApplicationController
  # GET /entities
  # GET /entities.json
  def index
    @entities = Tapir::Entity.instance.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entities }
    end
  end

  # GET /entities/1
  # GET /entities/1.json
  def show
    @entity = Tapir::Entities::Base.find(params[:id])

    #
    # Special case - this is serialized automatically
    # 
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
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /entities/new
  # GET /entities/new.json
  def new
    #@entity = Tapir::Entities::Base.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /entities/1/edit
  def edit
    @entity = Tapir::Entities::Base.find(params[:id])
  end

  # POST /entities
  # POST /entities.json
  def create
    #@entity = Tapir::Entities::Base.new(params[:entity])

    respond_to do |format|
      if @entity.save
        format.html { redirect_to @entity, notice: 'entity was successfully created.' }
        format.json { render json: @entity, status: :created, location: @entity }
      else
        format.html { render action: "new" }
        format.json { render json: @entity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entities/1
  # PUT /entities/1.json
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

  # DELETE /entities/1
  # DELETE /entities/1.json
  def destroy
    @entity = Tapir::Entities::Base.find(params[:id])
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to entities_url }
      format.json { head :ok }
    end
  end
end
