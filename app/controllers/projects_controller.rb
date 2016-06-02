class ProjectsController < ApplicationController
  before_action :set_project, except: {:index, :new, :create}


   private
    def set_project
      @project = Project.find_by(id: params[:id])
    end
end
