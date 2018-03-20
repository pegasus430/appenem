class V1::ExamsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: exams
  end

  private

  def exams
    Exam.joins(:schools).where(schools: { id: school_id }).order(year: :desc)
  end

  def school_id
    params.require(:school_id).to_i
  end
end
