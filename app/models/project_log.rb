class ProjectLog < ApplicationRecord
  belongs_to :project
  PROJECT_PAGENATE_COUNT = 5

  def self.paginate_index(project, page_num)
    ProjectLog.where(project_id: project.id).reverse_order.page(page_num).per(PROJECT_PAGENATE_COUNT)
  end

  def self.add_log(controller, action, user, project)
    ProjectLog.create(project_id: project.id, message: I18n.t("log.#{controller}.#{action}", user: user.name))
  end

  def self.add_move_card_log(controller, action, user, card)
    ProjectLog.create(project_id: card.project_id, message: I18n.t("log.#{controller}.#{action}", user: user.name, card: card.name, column: card.column_name))
  end

  def self.add_invite_log(controller, action, user, invitation)
    ProjectLog.create(project_id: invitation.project_id, message: I18n.t("log.#{controller}.#{action}", user: user.name, assignee: invitation.invitee_name))
  end

  def self.add_attend_log(controller, action, user, invitation)
    ProjectLog.create(project_id: invitation.project_id, message: I18n.t("log.#{controller}.#{action}", user: user.name))
  end

  def self.add_card_update_log(controller, action, user, card, is_changed_assign_user)
    ProjectLog.add_assign_log(controller, user, card) if is_changed_assign_user
    ProjectLog.add_log(controller, action, user, card.column.project) unless is_changed_assign_user
  end

  def self.add_assign_log(controller, user, card)
    ProjectLog.create(project_id: card.project_id, message: I18n.t("log.#{controller}.assign", user: user.name, card: card.name, assginee: card.assignee_name))
  end

  def self.add_card_deadline_log(card)
    ProjectLog.create(project_id: card.project_id, message: I18n.t('log.cards.deadline', card: card.name))
  end

  def self.add_card_overdue_log(card)
    ProjectLog.create(project_id: card.project_id, message: I18n.t('log.cards.overdue', card: card.name))
  end
end
