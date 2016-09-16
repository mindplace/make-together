class ReportsController < ApplicationController

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params.merge(user_id: current_user.id))
    if @report.save
      render 'thank_you'
    else
      render :new
    end
  end

  private

  def report_params
    params.require(:report).permit(:body)
  end
end
