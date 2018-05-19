class ProjectLog < ApplicationRecord
  belongs_to :project
  PROJECT_PAGENATE_COUNT = 5

  def self.paginate_index(project, page_num)
    ProjectLog.where(project_id: project.id).reverse_order.page(page_num).per(PROJECT_PAGENATE_COUNT)
  end

  def self.add_card_deadline_log(card)
    ProjectLog.create(project_id: card.project_id, message: I18n.t('log.cards.deadline', card: card.name))
  end

  def self.add_card_overdue_log(card)
    ProjectLog.create(project_id: card.project_id, message: I18n.t('log.cards.overdue', card: card.name))
  end
end
