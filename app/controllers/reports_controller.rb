class ReportsController < ApplicationController

  def list_all
    @entities = Tapir::Entities::Base.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entities }
    end
  end

  # GET /reports/google_default
  # GET /reports/google_default.json
  def google_default
    @loc = Tapir::Entities::PhysicalLocation.all
    
    @json =  "var sweetObj = {\'locations\': ["
    @loc.each do |loc|
      display  = ""

      loc.parents.each do |x|
        display << "Parent - <a href=\"#{request.url}/tapir/entities/#{x.id.to_s}\"> #{x.to_s}</a><br/>"
      end
      
      @json << "{\n\'name\': \'#{display}\',\n\'position\': [#{loc.latitude},#{loc.longitude}]\n},\n"
    end

    @json << "]}"
  
    respond_to do |format|
      format.html
      format.json { render json: @json }
    end
  end

  def organization_report
  end

  def index
    # query a list of all reports
  end

end
