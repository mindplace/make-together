class FavoritesController < ApplicationController

  def index

  end

  def new

  end

  def create

   @project = Project.find_by(id: params[:favorite][:project_id])
    @project.favorites << Favorite.new(user: current_user, project: @project)
    redirect_to project_path(@project)
  end

  def show
    @favorites = Favorite.where(user_id: current_user.id)


  end

end
