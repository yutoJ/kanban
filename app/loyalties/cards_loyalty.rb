class CardsLoyalty < ApplicationLoyalty
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
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

  def move?
    host_or_attending?(project)
  end
end
