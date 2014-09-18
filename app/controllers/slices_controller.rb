class SlicesController < ApplicationController
  before_action :set_slice, only: [:show, :edit, :update, :destroy]
  before_action :set_use_case, only: [:option, :new]

  # GET /slices
  # GET /slices.json
  def index
    @slices = Slice.all
  end

  # GET /slices/1
  # GET /slices/1.json
  def show
    # redirect HTML to Associated Use Case
    # render Slice JSON for JSON Request Format 
  end

  # GET /slices/new
  def new

    @slice = @project.slices.build
    respond_to do |format|
      format.js
    end
  end

  # GET /slices/1/edit
  def edit
  end

  # POST /slices
  # POST /slices.json
  def create
    @project = Project.find(params[:project_id])
    @slice = @project.slices.build(slice_params)
    puts slice_params[:flows_attributes]
    respond_to do |format|
      if @slice.save
        format.js
        format.html { redirect_to project_slice_path(@slice.project, @slice), notice: 'Slice was successfully created.' }
        format.json { render action: 'show', status: :created }
        
      else
        format.js {render action: 'new'}
        format.html { render action: 'new' }
        format.json { render json: @slice.errors, status: :unprocessable_entity }
        
      end
    end
  end


  # PATCH/PUT /slices/1
  # PATCH/PUT /slices/1.json
  def update
    respond_to do |format|
      if @slice.update(slice_params)
        format.html { redirect_to project_slice_path(project_id: @slice.project.id, id: @slice.id), notice: 'Slice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @slice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slices/1
  # DELETE /slices/1.json
  def destroy
    @slice.destroy
    respond_to do |format|
      format.html { redirect_to project_slices_url }
      format.json { head :no_content }
    end
  end

  # MARK FOR DELETION - NO LONGER NEEDED
  def option
    @project = Project.find(params[:project_id])
    @use_case = UseCase.where("project_id = ? and id = ?", @project.id, params[:use_case_id]).take
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_use_case
      @project = Project.find(params[:project_id])
      @use_case = UseCase.where("project_id =? and id=?", @project.id, params[:use_case_id]).take
    end

    def set_slice
      @project = Project.find(params[:project_id])
      @slice = Slice.where("project_id =? and id=?", @project.id, params[:id]).take
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slice_params
      params.require(:slice).permit(:use_case_id, :priority, :workflow_state, :estimate, :release_id, :order_priority,\
        flows_attributes: [:step_id, :_destroy])
    end
end
