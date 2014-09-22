class RevealController < ApplicationController

  def use_case
    @project = Project.find(params[:project_id])
    @use_case = UseCase.new(project: @project)
  end
  
  def piece
  end
end
