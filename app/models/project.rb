class Project < ApplicationRecord
  validates :name, presence: true, length: { maximum: 140 }
  validates :description, length: { maximum: 300 }

  belongs_to :user
  delegate :name, to: :user, prefix: true
  has_many :columns, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :project_members, dependent: :destroy

  PROJECT_COUNT_ON_FIRST_PAGE = 8
  PROJECT_COUNT_ON_EACH_AJAX = 9

  def self.paginate_index(projects, page_num, is_ajax)
    paginates_per = is_ajax ? PROJECT_COUNT_ON_EACH_AJAX : PROJECT_COUNT_ON_FIRST_PAGE
    projects.reverse_order.page(page_num).per(paginates_per)
  end
end
