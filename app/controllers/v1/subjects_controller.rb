class V1::SubjectsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: subject_frequencies,
           each_serializer: V1::SubjectFrequencySerializer
  end

  private

  def subject_frequencies
    fields = <<~SQL
      subjects.*,
      SUM(IF(
        alternatives.correct AND frequencies.school_id = :school_id,
        frequencies.frequency,
        0)) AS own_correct_answers,
      SUM(IF(
        frequencies.school_id = :school_id,
        frequencies.frequency,
        0)) AS own_answers,
      SUM(IF(
        alternatives.correct AND frequencies.school_id <> :school_id,
        frequencies.frequency,
        0)) AS comparison_correct_answers,
      SUM(IF(
        frequencies.school_id <> :school_id,
        frequencies.frequency,
        0)) AS comparison_answers
    SQL
    fields = Tag.send(:sanitize_sql_for_conditions,
                      [fields, school_id: school_id])

    Subject.select(fields)
         .joins(questions: [frequencies: :alternative])
         .where(questions: { exam_id: exam_id },
                subjects: { area_id: area_id },
                frequencies: { school_id: group_school_ids + [school_id] })
         .group(:id)
         .order(:name)
  end

  def area_id
    params.require(:area_id).to_i
  end

  def exam_id
    params.require(:exam_id).to_i
  end

  def school_id
    params.require(:school_id).to_i
  end

  def group_id
    params.require(:group_id).to_i
  end

  def group_school_ids
    @group_school_ids ||= School.joins(:groups)
                                .where(groups: { id: group_id })
                                .pluck(:id)
  end
end
