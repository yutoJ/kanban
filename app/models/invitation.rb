class Invitation < ApplicationRecord
  belongs_to :project
  delegate :name, to: :project, prefix: true
  delegate :user_name, to: :project, prefix: true
  belongs_to :invitee, class_name: 'User'
  delegate :name, to: :invitee, prefix: true
end
