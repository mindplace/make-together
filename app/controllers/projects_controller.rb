class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create]

  def index
    @projects = Project.all
    @favorite = Favorite.new
  end

  def new
    redirect_to root_path unless logged_in?
    @project = Project.new
    if request.xhr?
      render :_form, layout: false
    end
  end

  def next
    self.class.where("id > ?", id).first
  end

  def previous
    self.class.where("id < ?", id).last
  end

  def create
    @project = Project.new(project_params)
    set_image if @project.img == ""
    Tag.build_from_string(params[:project][:tags]).each do |tag|
      @project.tags << tag unless @project.tags.include?(tag)
    end
    if @project.save
      if request.xhr?
        render :_index_show, layout: false, locals: {project: @project}
      else
        redirect_to projects_path
      end
    else
      render :_form, layout: false, locals: {project: @project}
    end
  end

  def edit
    if !logged_in? || current_user && !is_poster?
      redirect_to root_path
    end
  end

  def update
    if @project.update(project_params)
      Tag.build_from_string(params[:project][:tags]).each do |tag|
         @project.tags << tag unless @project.tags.include?(tag)
       end
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def show
  end

  def posted_show
    @projects = current_user.projects
    render :posted_projects
  end

  private

  def project_params
    params.require(:project).permit(:title, :tagline, :description, :expiration, :user_id, :img)
  end

  def set_project
    @project = Project.find_by(id: params[:id])
  end

  def is_poster?
    @project.user == current_user
  end

  def set_image
    @project.img = "http://s33.postimg.org/5knvgprjj/shutterstock_194620346.jpg"
  end

end
