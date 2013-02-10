class EntitysController < ApplicationController
  # GET /entitys
  # GET /entitys.json
  def index
    @entitys = Tapir::Entity.instance.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entitys }
    end
  end

  # GET /entitys/1
  # GET /entitys/1.json
  def show
    @entity = Entity.find(params[:id])

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

  # GET /entitys/new
  # GET /entitys/new.json
  def new
    @entity = Entity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entity }
    end
  end

  # GET /entitys/1/edit
  def edit
    @entity = Entity.find(params[:id])
  end

  # POST /entitys
  # POST /entitys.json
  def create
    @entity = Entity.new(params[:entity])

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

  # PUT /entitys/1
  # PUT /entitys/1.json
  def update
    @entity = Entity.find(params[:id])

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

  # DELETE /entitys/1
  # DELETE /entitys/1.json
  def destroy
    @entity = Entity.find(params[:id])
    @entity.destroy

    respond_to do |format|
      format.html { redirect_to entitys_url }
      format.json { head :ok }
    end
  end
end
