class ProjectsLoyalty < ApplicationLoyalty
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def show?
    host_or_attending?(project)
  end
end
