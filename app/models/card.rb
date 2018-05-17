class Card < ApplicationRecord
  belongs_to :project
  belongs_to :column
  belongs_to :assignee, class_name: 'User'

  validates :name, presence: true, length: { maximum: 40 }

  def first_column?(positions)
    column_id == positions.first.column_id
  end

  def last_column?(positions)
    column_id == positions.last.column_id
  end
end
