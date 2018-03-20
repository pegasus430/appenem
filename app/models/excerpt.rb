class Excerpt
  include ActiveModel::Serialization

  def initialize(school, excerpt, ranking_type)
    @school = school
    @excerpt = excerpt
    @ranking_type = ranking_type
  end

  def id
    school.id
  end

  def areas
    Area.order(:name).pluck(:short_name)
  end

  def schools
    excerpt.map do |summary|
      { id: summary.school.id,
        position: summary.public_send(ranking_type),
        name: summary.school.name,
        general_score: summary.general_score,
        area_scores: [summary.cn_score, summary.ch_score, summary.lc_score,
                      summary.mt_score] }
    end
  end

  private

  attr_reader :school, :excerpt, :ranking_type
end
