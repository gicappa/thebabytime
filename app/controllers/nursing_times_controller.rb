class NursingTimesController < ApplicationController
  # GET /nursing_times
  # GET /nursing_times.json
  def index
    @nursing_times = NursingTime.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nursing_times }
    end
  end

  # GET /nursing_times/1
  # GET /nursing_times/1.json
  def show
    @nursing_time = NursingTime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nursing_time }
    end
  end

  # GET /nursing_times/new
  # GET /nursing_times/new.json
  def new
    @nursing_time = NursingTime.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nursing_time }
    end
  end

  # GET /nursing_times/1/edit
  def edit
    @nursing_time = NursingTime.find(params[:id])
  end

  # POST /nursing_times
  # POST /nursing_times.json
  def create
    @nursing_time = NursingTime.new(params[:nursing_time])

    respond_to do |format|
      if @nursing_time.save
        format.html { redirect_to @nursing_time, notice: 'Nursing time was successfully created.' }
        format.json { render json: @nursing_time, status: :created, location: @nursing_time }
      else
        format.html { render action: "new" }
        format.json { render json: @nursing_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nursing_times/1
  # PUT /nursing_times/1.json
  def update
    @nursing_time = NursingTime.find(params[:id])

    respond_to do |format|
      if @nursing_time.update_attributes(params[:nursing_time])
        format.html { redirect_to @nursing_time, notice: 'Nursing time was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @nursing_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nursing_times/1
  # DELETE /nursing_times/1.json
  def destroy
    @nursing_time = NursingTime.find(params[:id])
    @nursing_time.destroy

    respond_to do |format|
      format.html { redirect_to nursing_times_url }
      format.json { head :ok }
    end
  end
end
