class ProjectsLoyalty < ApplicationLoyalty
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def show?
    host_or_attending?(project)
  end

  def new?
    host_or_attending?(project)
  end

  def create?
    host_or_attending?(project)
  end

  def edit?
    host_or_attending?(project)
  end

  def update?
    host_or_attending?(project)
  end

  def destroy?
    host_or_attending?(project)
  end
end
