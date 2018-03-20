class ScoreEvolution
  include ActiveModel::Serialization

  def initialize(school, group, area_id)
    @school = school
    @group = group
    @area_id = area_id
  end

  def school_evolution
    Score.joins(candidate: :exam)
         .merge(Candidate.valid)
         .where(area_id: area_id,
                candidates: { school: school,
                              presence: 'present' })
         .group('exams.year')
         .average(:score)
         .map{ |k,v| { year: k, avg_score: v } }
  end

  def group_evolution
    Score.joins(candidate: :exam)
         .merge(Candidate.valid)
         .where(area_id: area_id,
                candidates: { school: group.schools,
                              presence: 'present' })
         .group('exams.year')
         .average(:score)
         .map{ |k,v| { year: k, avg_score: v } }
  end

  private

  attr_reader :school, :group, :area_id
end
