class Invitation < ApplicationRecord
  attr_accessor :user

  belongs_to :project
  delegate :name, to: :project, prefix: true
  delegate :user_name, to: :project, prefix: true
  belongs_to :invitee, class_name: 'User'
  delegate :name, to: :invitee, prefix: true

  after_create do
    ProjectLog.create(project_id: project_id, message: I18n.t('log.invitations.create', user: user.name, assignee: invitee_name))
  end

  after_update do
    ProjectLog.create(project_id: project_id, message: I18n.t('log.invitations.accept', user: invitee_name))
  end
end
