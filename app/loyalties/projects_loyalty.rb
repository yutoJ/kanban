class ProjectsLoyalty < ApplicationLoyalty
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def show?
    host_or_attending?(project)
  end

  def edit?
    my_project?
  end

  def update?
    my_project?
  end

  def destroy?
    my_project?
  end

  def invite?
    my_project?
  end

  def logs?
    host_or_attending?(project)
  end

  private

  def my_project?
    project.user_id == user.id
  end
end
