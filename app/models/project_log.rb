class ProjectLog < ApplicationRecord
  belongs_to :project
  def self.add_log(controller, action, user, project)
    ProjectLog.create(project_id: project.id, message: I18n.t("log.#{controller}.#{action}", user: user.name))
  end

  def self.add_move_card_log(controller, action, user, card)
    ProjectLog.create(project_id: card.project_id, message: I18n.t("log.#{controller}.#{action}", user: user.name, card: card.name, column: card.column.name))
  end

  def self.add_invite_log(controller, action, user, invitation)
    ProjectLog.create(project_id: invitation.project_id, message: I18n.t("log.#{controller}.#{action}", user: user.name, assignee: invitation.invitee.name))
  end

  def self.add_attend_log(controller, action, user, invitation)
    ProjectLog.create(project_id: invitation.project_id, message: I18n.t("log.#{controller}.#{action}", user: user.name))
  end

  def self.add_assign_log(controller, user, card)
    ProjectLog.create(project_id: card.project_id, message: I18n.t("log.#{controller}.assign", user: user.name, card: card.name, assginee: card.assignee.name))
  end
end
