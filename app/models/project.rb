class Project < ApplicationRecord
  validates :name, presence: true, length: { maximum: 140 }
  validates :description, length: { maximum: 300 }

  belongs_to :user

  @project_count_on_first_page = 8
  @project_count_on_each_ajax = 9

  def self.paginate_index(projects, page_num, is_ajax)
    paginates_per = is_ajax ? @project_count_on_each_ajax : @project_count_on_first_page
    projects.reverse_order.page(page_num).per(paginates_per)
  end
end
