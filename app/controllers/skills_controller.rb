class SkillsController < ApplicationController
  before_action :set_skill, except: [:new, :create]
  def new
    if logged_in?
      @skill = Skill.new
    else
      redirect_to root_path
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
