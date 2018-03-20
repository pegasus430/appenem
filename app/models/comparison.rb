class Comparison
  include ActiveModel::Serialization

  def initialize(current_school, other_schools, ranking_type)
    @current_school = current_school
    @other_schools = other_schools
    @ranking_type = ranking_type
  end

  def years
    Exam.order(:year).pluck(:year)
  end

  def school
    series(current_school)
  end

  def comparison_schools
    other_schools.map { |school| series(school) }
  end

  private

  def series(school)
    left_join = <<~SQL
      LEFT JOIN summaries ON exams.id = summaries.exam_id
                          AND summaries.school_id = #{School.sanitize(school.id)}
    SQL
    { positions: Exam.joins(left_join)
                     .order('exams.id')
                     .pluck("summaries.#{ranking_type}"),
      name: school.name }
  end

  attr_reader :current_school, :other_schools, :ranking_type
end
