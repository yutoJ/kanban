class Column < ApplicationRecord
  attr_accessor :user

  belongs_to :project
  validates :name, presence: true, length: { maximum: 40 }
  validates :project_id, presence: true

  has_one :column_position, dependent: :destroy
  has_many :cards, dependent: :destroy

  after_create do
    add_log('log.columns.create')
  end

  after_update do
    add_log('log.columns.update')
  end

  after_destroy do
    add_log('log.columns.destroy')
  end

  def save_with_column_position
    ColumnPosition.add_seq_record_to(self)
    save
  end

  private

  def add_log(msg_path)
    ProjectLog.create(project_id: project.id, message: I18n.t(msg_path, user: user.name))
  end
end
