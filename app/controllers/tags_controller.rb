class TagsController < ApplicationController
  before_action :set_tag, except: [:new, :create]

  def show
  end

  def destroy
  end

  private
  def set_tag
    @tag = Tag.find_by(id: params[:id])
  end


end
