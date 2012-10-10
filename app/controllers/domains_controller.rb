class DomainsController < ApplicationController
  # GET /domains
  # GET /domains.json
  def index
    @domains = Tapir::Entities::Domain.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @domains }
    end
  end

  # GET /domains/1
  # GET /domains/1.json
  def show
    @domain = Tapir::Entities::Domain.find(params[:id])

    #
    # Special case - this is serialized automatically
    # 
    if @domain.referral_whois
      @domain_referral_whois_array = YAML::load(@domain.referral_whois)
      #
      # this may still be a string
      #
      @domain_referral_whois_array = [@domain_referral_whois_array] if 
        @domain_referral_whois_array.kind_of? String
    else
      @domain_referral_whois_array = []
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @domain }
    end
  end

  # GET /domains/new
  # GET /domains/new.json
  def new
    @domain = Tapir::Entities::Domain.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @domain }
    end
  end

  # GET /domains/1/edit
  def edit
    @domain = Domain.find(params[:id])
  end

  # POST /domains
  # POST /domains.json
  def create
    @domain = Tapir::Entities::Domain.new(params[:tapir_entities_domain])

    respond_to do |format|
      if @domain.save
        format.html { redirect_to @domain, notice: 'Domain was successfully created.' }
        format.json { render json: @domain, status: :created, location: @domain }
      else
        format.html { render action: "new" }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /domains/1
  # PUT /domains/1.json
  def update
    @domain = Tapir::Entities::Domain.find(params[:id])

    respond_to do |format|
      if @domain.update_attributes(params[:tapir_entities_domain])
        format.html { redirect_to @domain, notice: 'Domain was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /domains/1
  # DELETE /domains/1.json
  def destroy
    @domain = Tapir::Entities::Domain.find(params[:id])
    @domain.destroy

    respond_to do |format|
      format.html { redirect_to tapir_entities_domains_url }
      format.json { head :ok }
    end
  end
end
