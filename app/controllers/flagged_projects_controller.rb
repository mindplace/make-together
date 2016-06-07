class FlaggedProjectsController < ApplicationController

  def create
    @flagged_project = FlaggedProject.create(project_id: params[:project_id], user_id: current_user.id)
    redirect_to project_path(@flagged_project.project)
  end

  def show
    @projects = Project.where(flagged: true)
  end

  def destroy
    @project = Project.find_by(id: params[:project_id])
    @flagged_project = FlaggedProject.find_by(project_id: params[:project_id])
    @flagged_project.destroy
    redirect_to project_path(@project)

  end
end
