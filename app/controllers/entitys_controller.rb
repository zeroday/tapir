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
end
