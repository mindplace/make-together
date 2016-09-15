class ReportsController < ApplicationController

  def new
    @report = Report.new
  end

  def create
    @report = Report.new(report_params.merge(user_id: current_user.id))
    @report.save ? render 'thank_you' : render :new
  end

  private

  def report_params
    params.require(:report).permit(:body)
  end
end
