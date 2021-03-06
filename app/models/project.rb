class Project < ApplicationRecord
  validates :name, presence: true, length: { maximum: 140 }
  validates :description, length: { maximum: 300 }
  validates :user_id, presence: true

  belongs_to :user
  delegate :name, to: :user, prefix: true
  has_many :columns, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :invitations, dependent: :destroy
  has_many :project_logs, dependent: :destroy

  PROJECT_COUNT_ON_FIRST_PAGE = 8
  PROJECT_COUNT_ON_EACH_AJAX = 9

  def self.paginate_index(projects, page_num, is_ajax)
    paginates_per = is_ajax ? PROJECT_COUNT_ON_EACH_AJAX : PROJECT_COUNT_ON_FIRST_PAGE
    projects.reverse_order.page(page_num).per(paginates_per)
  end

  def self.paginate_myprojects_index(projects, page_num, is_ajax)
    paginates_per = is_ajax ? PROJECT_COUNT_ON_EACH_AJAX : PROJECT_COUNT_ON_FIRST_PAGE
    Kaminari.paginate_array(projects.reverse).page(page_num).per(paginates_per)
  end

  def members
    attending_user_ids = invitations.where(accept: true).map(&:invitee_id)
    members_ids = [user.id] + attending_user_ids
    User.find(members_ids)
  end
end
