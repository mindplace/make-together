class TagsController < ApplicationController
  protect_from_forgery with: :null_session, only: Proc.new { |c| c.request.format.json? }
  before_action :set_tag, except: [:new, :create]

  def show
    if request.xhr?
      @tag = Tag.find_by(body: params[:body])
      @searched = params[:body]
        if !@tag
          render "/projects/_no_results", layout: false
        else
          @projects = @tag.projects
          render :show, layout: false
        end
    else
      @tag = Tag.find_by(id: params[:id])
      @projects = @tag.projects
      @not_ajax = true
    end
  end

  def destroy
  end

  private

  def set_tag
    @tag = Tag.find_by(id: params[:id])
  end

end
