class UseCasesController < ApplicationController
  before_action :set_use_case, only: [:show, :edit, :update, :destroy]

  # GET /use_cases
  # GET /use_cases.json
  def index
    @project = Project.find(params[:project_id])
    @use_cases = UseCase.where(project: @project)
  end

  # GET /use_cases/1
  # GET /use_cases/1.json
  def show
    @slices = @use_case.slices.includes(:steps)
  end

  # GET /use_cases/new
  def new
    @project = Project.find(params[:project_id])
    @use_case = @project.use_cases.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /use_cases/1/edit
  def edit
  end

  # POST /use_cases
  # POST /use_cases.json
  def create
    @project = Project.find(params[:project_id])
    @use_case = @project.use_cases.build(use_case_params)
    respond_to do |format|
      if @use_case.save
        @use_cases = @project.use_cases
        format.html { redirect_to project_use_case_path(@use_case.project, @use_case), notice: 'Use case was successfully created.' }
        format.json { render action: 'show', status: :created, location: @use_case }
        format.js
      else
        format.html { render action: 'new' }
        format.json { render json: @use_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /use_cases/1
  # PATCH/PUT /use_cases/1.json
  def update
    respond_to do |format|
      if @use_case.update(use_case_params)
        format.html { redirect_to project_use_case_path(project_id: @use_case.project.id, id: @use_case.id), notice: 'Use case was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @use_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /use_cases/1
  # DELETE /use_cases/1.json
  def destroy
    @use_case.destroy
    respond_to do |format|
      format.html { redirect_to project_use_cases_url }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_use_case
      @project = Project.find(params[:project_id])
      @use_case = UseCase.where("project_id =? and id=?", @project.id, params[:id]).take
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def use_case_params
      params.require(:use_case).permit(:name, :description, :pre_condition, :standard_flow, :alternate_flow, :post_condition, :open_issue, :state, :project_id, \
          pieces_attributes: [:name, :doc, :_destroy], steps_attributes: [:description, :state, :type, :_destroy])
    end
end
