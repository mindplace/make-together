class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create]

  def index
    @projects = Project.all
    @favorite = Favorite.new
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
    Tag.build_from_string(params[:project][:tags]).each do |tag|
         @project.tags << tag unless @project.tags.include?(tag)
       end
    if @project.save
      redirect_to projects_path
    else
      render 'new'
    end
  end

  def edit
    if !user_signed_in? || user_signed_in? &&!is_poster?
      render :_unauthorized
    end
  end

  def update
    if user_signed_in? && is_poster?
      if @project.update(project_params)
        redirect_to project_path(@project)
      else
        render :edit
      end
    else
      render :_unauthorized
    end
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

  def is_poster?
    @project.user == current_user
  end
end