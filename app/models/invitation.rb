class Invitation < ApplicationRecord
  belongs_to :project
  belongs_to :invitee, class_name: 'User'

  def project_name
    project.name
  end

  def project_user_name
    project.user_name
  end
end
