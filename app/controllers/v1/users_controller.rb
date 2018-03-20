class V1::UsersController < ApplicationController
  before_action :authenticate_user!

  def current
    render json: {
             name: current_user.name,
             role: current_user.role,
             email: current_user.email,
             phone: current_user.phone,
             full_access: current_user.full_access,
             origin_id: current_user.origin_id,
             school_id: school_id,
             area_id: area_id,
             group_id: group_id,
             exam_id: exam_id,
             groups: groups,
             exams: exams,
             schools: schools.includes(:exams).map { |school|
               { id: school.id,
                 name: school.name,
                 dependency: school.dependency,
                 exams: school.exams }
             }
           },
           includes: { schools: :exams }

  end

  private

  def school_id
    school.id
  end

  def area_id
    Area.first.id
  end

  def exam_id
    exams.last.id
  end

  def group_id
    groups.first.id
  end

  def groups
    current_user.groups
  end

  def exams
    school.exams
  end

  def schools
    current_user.schools
  end

  def school
    schools.first
  end
end
