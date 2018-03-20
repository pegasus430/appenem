class QuestionDetail
  include ActiveModel::Serialization

  attr_reader :alternatives

  def initialize(question, alternatives)
    @question = question
    @alternatives = alternatives
  end

  def id
    question.id
  end

  def position
    question.position
  end

  def label
    question.label
  end

  def content
    question.content
  end

  def skill
    question.skill
  end

  def tags
    question.tags
  end

  def subject
    question.subject
  end

  private

  attr_reader :question
end
