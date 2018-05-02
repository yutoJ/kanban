class Card < ApplicationRecord
  belongs_to :project
  belongs_to :column
  belongs_to :assignee, class_name: 'User'

  validates :name, presence: true, length: { maximum: 40 }
end
