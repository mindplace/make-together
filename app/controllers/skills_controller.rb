class SkillsController < ApplicationController
  before_action :set_skill, except: [:new, :create]
  def new
    if logged_in?
      @skill = Skill.new
      if request.xhr?
        render :_form, layout: false
      end
    else
      redirect_to root_path
    end
  end

  def create
    @skill = Skill.find_or_create_by(skill_params)
    current_user.skills << @skill
    if request.xhr?
      render :_individual_skill, layout: false, locals: {skill: @skill}
    else
      redirect_to user_path(current_user)
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
    SkillUser.find_by(skill_id: @skill.id, user_id: current_user.id).destroy
    if request.xhr?
      render :response, layout: false
    else
      redirect_to 'users/show'
    end
  end

  private

  def set_skill
    @skill = Skill.find_by(id: params[:id])
  end

  def skill_params
    params.require(:skill).permit(:body)
  end
end
