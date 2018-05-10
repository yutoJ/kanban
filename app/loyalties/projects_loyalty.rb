class ProjectsLoyalty < ApplicationLoyalty
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def show?
    user.my_projects.map(&:id).include?(project.id)
  end
end
