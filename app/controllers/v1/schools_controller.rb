class V1::SchoolsController < ApplicationController
  before_action :authenticate_user!, except: [:search]

  def search
    if with_exams?
      render json: schools_by_term.includes(:exams),
             each_serializer: V1::SchoolWithExamsSerializer
    else
      render json: schools_by_term
    end
  end

  def show
    render json: DiffSummary.new(last_summaries)
  end

  def ranking
    render json: Excerpt.new(current_school, excerpt, ranking_type)
  end

  def comparison
    render json: Comparison.new(current_school, comparison_schools,
                                ranking_type)
  end

  def histogram
    render json: HistogramComparison.new(school_scores(current_school),
                                        school_scores(comparison_schools))
  end

  def overview
    render json: OverviewComparison.new(school_scores(current_school),
                                        school_scores(comparison_schools))
  end

  def evolution
    render json: ScoreEvolution.new(current_school, current_group, area_id)
  end

  private

  def current_group
    @current_group ||= Group.find(group_id)
  end

  def current_school
    @current_school ||= School.includes(city: :state).find(school_id)
  end

  def school_id
    params.require(:school_id).to_i
  end

  def exam_id
    params.require(:exam_id).to_i
  end

  def area_id
    params.require(:area_id).to_i
  end

  def group_id
    params.require(:group_id).to_i
  end

  def with_exams?
    params[:with_exams] || false
  end

  def term
    params[:term].gsub(/ +/, '%')
  end

  def schools_by_term
    return School.none if term.blank?
    schools = School.where('name LIKE ?', "%#{term}%").joins(:exams).distinct.limit(30)
  end

  def group_school_ids
    @group_school_ids ||= School.joins(:groups)
                                .where(groups: { id: group_id })
                                .pluck(:id)
  end

  def type
    return 'country' unless ['city', 'state', 'country'].include?(params[:type])
    params['type']
  end

  def last_summaries
    current_school.summaries
                  .joins(:exam)
                  .where('exams.year <= ?', Exam.find(exam_id).year)
                  .order('exams.year DESC')
  end

  def summary
    @summary ||= current_school.summaries.find_by(exam_id: exam_id)
  end

  def schools_by_type
    if type == 'city'
      current_school.city.schools
    elsif type == 'state'
      current_school.state.schools
    else
      School.all
    end
  end

  def ranking_type
    "#{type}_ranking"
  end

  def summaries
    Summary.where(school_id: schools_by_type, exam_id: exam_id)
           .order(ranking_type)
  end

  def excerpt
    position = summary.public_send(ranking_type)
    summaries
      .where("#{ranking_type} BETWEEN ? AND ?", position - 2, position + 2)
      .includes(:school)
  end

  def comparison_schools
      current_group.schools.where(id: schools_by_type)
  end

  def school_scores(school)
    Score.joins(:candidate)
         .merge(Candidate.valid)
         .where(candidates: { school_id: school,
                              presence: 'present',
                              exam_id: exam_id },
                area_id: area_id)
  end
end
