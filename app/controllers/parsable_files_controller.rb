class ParsableFilesController < ApplicationController
  # GET /parsable_files
  # GET /parsable_files.json
  def index
    @parsable_files = Tapir::Entities::ParsableFile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @parsable_files }
    end
  end

  # GET /parsable_files/1
  # GET /parsable_files/1.json
  def show
    @parsable_file = Tapir::Entities::ParsableFile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @parsable_file }
    end
  end

  # GET /parsable_files/new
  # GET /parsable_files/new.json
  def new
    @parsable_file = Tapir::Entities::ParsableFile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @parsable_file }
    end
  end

  # GET /parsable_files/1/edit
  def edit
    @parsable_file = Tapir::Entities::ParsableFile.find(params[:id])
  end

  # POST /parsable_files
  # POST /parsable_files.json
  def create
    @parsable_file = Tapir::Entities::ParsableFile.new(params[:tapir_entities_parsable_file])

    respond_to do |format|
      if @parsable_file.save
        format.html { redirect_to @parsable_file, notice: 'Parsable file was successfully created.' }
        format.json { render json: @parsable_file, status: :created, location: @parsable_file }
      else
        format.html { render action: "new" }
        format.json { render json: @parsable_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /parsable_files/1
  # PUT /parsable_files/1.json
  def update
    @parsable_file = Tapir::Entities::ParsableFile.find(params[:id])

    respond_to do |format|
      if @parsable_file.update_attributes(params[:tapir_entities_parsable_file])
        format.html { redirect_to @parsable_file, notice: 'Parsable file was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @parsable_file.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parsable_files/1
  # DELETE /parsable_files/1.json
  def destroy
    @parsable_file = Tapir::Entities::ParsableFile.find(params[:id])
    @parsable_file.destroy

    respond_to do |format|
      format.html { redirect_to parsable_files_url }
      format.json { head :ok }
    end
  end
end
