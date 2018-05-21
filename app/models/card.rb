class Card < ApplicationRecord
  attr_accessor :user

  belongs_to :project
  belongs_to :column
  delegate :name, to: :column, prefix: true
  belongs_to :assignee, class_name: 'User'
  delegate :name, to: :assignee, prefix: true
  delegate :sns_image, to: :assignee, prefix: true

  validates :name, presence: true, length: { maximum: 40 }
  validates :project_id, presence: true
  validates :column_id, presence: true

  after_create do
    add_log('log.cards.create')
  end

  before_update do
    if changed.include?('assignee_id')
      ProjectLog.create(project_id: project_id, message: I18n.t('log.cards.assign', user: user.name, card: name, assginee: assignee_name))
    elsif changed.include?('column_id')
      ProjectLog.create(project_id: project_id, message: I18n.t('log.cards.move', user: user.name, card: name, column: column_name))
    else
      add_log('log.cards.update')
    end
  end

  after_destroy do
    add_log('log.cards.destroy')
  end

  def first_column?(positions)
    column_id == positions.first.column_id
  end

  def last_column?(positions)
    column_id == positions.last.column_id
  end

  private

  def add_log(msg_path)
    ProjectLog.create(project_id: project.id, message: I18n.t(msg_path, user: user.name))
  end
end
