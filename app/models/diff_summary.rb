class DiffSummary
  include ActiveModel::Serialization

  def initialize(relation)
    @first = relation.first
    @second = relation.second
  end

  def id
    first.school.id
  end

  def name
    first.school.name
  end

  def score
    first.general_score.to_f
  end


  def positions
    [city, state, country]
  end

  private

  attr_reader :first, :second

  def city
    { position: first.city_ranking,
      type: 'city',
      name: first.school.city.name,
      displacement:
        second.present? ? first.city_ranking - second.city_ranking : 0 }
  end

  def state
    { position: first.state_ranking,
      type: 'state',
      name: first.school.city.state.name,
      displacement:
        second.present? ? first.state_ranking - second.state_ranking : 0 }
  end

  def country
    { position: first.country_ranking,
      type: 'country',
      name: 'Brasil',
      displacement:
        second.present? ? first.country_ranking - second.country_ranking: 0 }
  end
end
