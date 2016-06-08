class FlaggedProjectsController < ApplicationController

  def create
    @flagged_project = FlaggedProject.create(project_id: params[:project_id], user_id: current_user.id)
    if request.xhr?
      render "/projects/_unreport", layout: false, locals: {project: @flagged_project.project}
    else
      redirect_to project_path(@flagged_project.project)
    end
  end

  def show
    @projects = Project.where(flagged: true)
  end

  def destroy
    @flagged_project = FlaggedProject.find_by(id: params[:id])
    @flagged_project.destroy
    if request.xhr?
      render "/projects/_report", layout: false, locals: {project: @flagged_project.project}
    else
      redirect_to project_path(@flagged_project.project)
    end

  end
end
