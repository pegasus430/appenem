class User < ActiveRecord::Base
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         password_length: 6..128

  include DeviseTokenAuth::Concerns::User

  before_validation :create_default_group, on: :create

  validates_presence_of :name, :phone, :role, :schools, :groups

  has_and_belongs_to_many :schools
  has_many :groups, dependent: :delete_all

  belongs_to :origin, optional: true

  def school
    @schools ||= schools.first
  end

  protected

  # Overriding Devise Token Auth uniqueness validation
  def unique_email_user
    return unless provider == 'email'
    return unless self.class
                      .where(provider: 'email', email: email, origin: origin)
                      .count > 0
    errors.add(:email, :taken)
  end

  # Overriding Devise Token Auth Uid for authentication
  def sync_uid
    return unless provider == 'email'
    self.uid = origin.present? ? "#{origin.name}.#{email}" : email
  end

  private

  def last_summary
    @last_summary ||= school.summaries.order(exam_id: :desc).first
  end

  def city_comparison_schools
    @city_comparison_schools ||= begin
      Summary.joins(:school)
             .where('city_ranking BETWEEN ? AND ?',
                    last_summary.city_ranking - 2,
                    last_summary.city_ranking + 2)
             .where(exam_id: last_summary.exam_id)
             .where(schools: { city: last_summary.school.city })
             .pluck(:school_id) - [last_summary.school_id]
    end
  end

  def state_comparison_schools
    @state_comparison_schools ||= begin
      Summary.joins(school: :city)
             .where('state_ranking BETWEEN ? AND ?',
                    last_summary.state_ranking - 1,
                    last_summary.state_ranking + 1)
             .where(exam_id: last_summary.exam_id)
             .where(cities: { state_id: last_summary.school.city.state_id })
             .pluck(:school_id) - [last_summary.school_id]
    end
  end

  def create_default_group
    return if groups.any? || schools.empty?
    range_schools = if city_comparison_schools.any?
                      city_comparison_schools
                    else
                      state_comparison_schools
                    end
    self.groups << Group.new(name: 'Padrão', schools: School.find(range_schools))
  end
end
