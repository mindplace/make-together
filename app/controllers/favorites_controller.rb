class FavoritesController < ApplicationController

  def index
    if current_user
      @favorites = current_user.favorites
    else
      redirect_to root_path
    end
  end

  def create
    @project = Project.find_by(id: params[:project_id])
    favorite = Favorite.find_or_create_by(user:current_user, project: @project)
    if request.xhr?
      render :_red_heart, layout: false, locals: {project: @project}
    else
      redirect_to projects_path
    end
  end


  def destroy
    favorite= Favorite.find_by(id: params[:id]).destroy
    if request.xhr?
      render :_grey_heart, layout: false, locals: {project: favorite.project}
    else
      redirect_to projects_path
    end
  end

end
