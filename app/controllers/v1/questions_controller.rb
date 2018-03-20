class V1::QuestionsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: question_frequencies,
           each_serializer: V1::QuestionFrequencySerializer
  end

  def show
    render json: question_detail
  end

  private

  def question_frequencies
    fields = <<~SQL
      questions.*,
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

    fields = Question.send(:sanitize_sql_for_conditions,
                           [fields, school_id: school_id])

    Question.select(fields)
            .preload(:skill, :subject, :tags)
            .joins(:subject, frequencies: :alternative)
            .where(exam_id: exam_id,
                   subjects: { area_id: area_id },
                   frequencies: { school_id: group_school_ids + [school_id] })
            .group(:id)
            .order(:position)
  end

  def question_detail
    fields = <<~SQL
      alternatives.*,
      SUM(IF(
        frequencies.school_id = :school_id,
        frequencies.frequency,
        0)) AS own_frequency,
      SUM(IF(
        frequencies.school_id <> :school_id,
        frequencies.frequency,
        0)) AS comparison_frequency
    SQL
    fields = Alternative.send(:sanitize_sql_for_conditions,
                              [fields, school_id: school_id])

    frequencies = <<~SQL
      LEFT JOIN frequencies
        ON frequencies.alternative_id = alternatives.id
        AND frequencies.school_id IN (:school_id)
    SQL
    frequencies = Alternative.send(
      :sanitize_sql_for_conditions,
      [frequencies, school_id: group_school_ids + [school_id]])

    question = Question.find(question_id)
    alternatives = Alternative
      .select(fields)
      .joins(frequencies)
      .where(question_id: question_id)
      .group(:id)

    QuestionDetail.new(question, alternatives)
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

  def question_id
    params.require(:question_id).to_i
  end

  def group_school_ids
    @group_school_ids ||= School.joins(:groups)
                                .where(groups: { id: group_id })
                                .pluck(:id)
  end
end
