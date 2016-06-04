class TagsController < ApplicationController
  before_action :set_tag, except: [:new, :create]

  def show
    @tag = Tag.find_by(body: params[:body])
    @searched = params[:body]
    if !@tag
      render "/_no_results"
    end
  end

  def destroy
  end

  private
  def set_tag
    @tag = Tag.find_by(id: params[:id])
  end


end
