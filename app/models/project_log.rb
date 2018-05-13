class ProjectLog < ApplicationRecord
  belongs_to :project
  def self.add_log(project, message)
    ProjectLog.create(project_id: project.id, message: message)
  end
end
