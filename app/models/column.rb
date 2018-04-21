class Column < ApplicationRecord
  belongs_to :project
  validates :name, presence: true, length: { maximum: 40 }
end
