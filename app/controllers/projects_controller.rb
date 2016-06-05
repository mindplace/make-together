class ProjectsController < ApplicationController
  before_action :set_project, except: [:index, :new, :create]

  def index
    @projects = Project.all
    @favorite = Favorite.new
  end

  def new
     if logged_in?
        @project = Project.new
     else
       redirect_to root_path
     end
  end

  def create
    @project = Project.new(project_params)
    @project.set_image
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
    if !logged_in? || current_user && !is_poster?
      redirect_to root_path
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_path(@project)
    else
      render :edit
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

  def set_image
    images = ["http://image005.flaticon.com/1/svg/14/14427.svg", "http://image005.flaticon.com/1/svg/29/29104.svg", "http://image005.flaticon.com/17/svg/56/56361.svg", "http://image005.flaticon.com/11/svg/9/9299.svg", "http://image005.flaticon.com/1/svg/29/29594.svg", "http://image005.flaticon.com/1/svg/71/71724.svg", "http://image005.flaticon.com/1/svg/35/35446.svg", "http://image005.flaticon.com/1/svg/68/68792.svg"]
    @project.img = images.sample
  end
end
