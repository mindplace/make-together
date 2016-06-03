class SkillsController < ApplicationController
  before_action :set_skill, except: [:new, :create]
  def new
    if user_signed_in?
      @skill = Skill.new
    else
      render "/_unauthorized"
    end
  end

  def create
    Skill.build_from_string(params[:skill][:body]).each do |skill|
        current_user.skills << skill unless current_user.skills.include?(skill)
      end
    redirect_to user_path(current_user)
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private
  def set_skill
    @skill = Skill.find_by(id: params[:id])
  end
end
