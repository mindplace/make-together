class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create]

  def index
    @projects = Project.all
  end

   private
    def set_project
      @project = Project.find_by(id: params[:id])
    end
end
