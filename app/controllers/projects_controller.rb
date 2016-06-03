class ProjectsController < ApplicationController
 before_action :set_project, except: [:index, :new, :create]

 def index
   @projects = Project.all
 end

 def new
    if user_signed_in?
       @project = Project.new
    else
      render "/_unauthorized"
    end
 end

 def create
   @project = Project.new(project_params)
   if @project.save
     redirect_to projects_path
   else
     render 'new'
   end
 end

 def edit
 end

 def update

   @project.update_attributes(project_params)
   redirect_to project_path(@project)


 end

 def show
 end

 private

 def project_params
   params.require(:project).permit(:title, :tagline, :description, :expiration, :user_id)
 end
   def set_project
     @project = Project.find_by(id: params[:id])
   end
end