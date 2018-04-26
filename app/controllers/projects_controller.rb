class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: %i[index myproject]
  def index
    @projects = paginate_index(Project)
  end

  def myproject
    @projects = paginate_index(current_user.projects)
  end

  private

  def paginate_index(projects)
    project_count_on_first_page = 8
    project_count_on_each_ajax = 9
    paginates_per = request.xhr? ? project_count_on_each_ajax : project_count_on_first_page
    projects.page(params[:page]).per(paginates_per)
  end
end
