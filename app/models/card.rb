class Card < ApplicationRecord
  belongs_to :project
  belongs_to :column
  delegate :name, to: :column, prefix: true
  belongs_to :assignee, class_name: 'User'
  delegate :name, to: :assignee, prefix: true
  delegate :sns_image, to: :assignee, prefix: true

  validates :name, presence: true, length: { maximum: 40 }

  def first_column?(positions)
    column_id == positions.first.column_id
  end

  def last_column?(positions)
    column_id == positions.last.column_id
  end
end
