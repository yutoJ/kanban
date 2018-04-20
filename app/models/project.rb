class Project < ApplicationRecord
  validates :name, presence: true, length: { maximum: 140 }
  validates :name, length: { maximum: 300 }

  belongs_to :user
end
