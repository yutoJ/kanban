class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: %i[index myproject create new]
  def index
    @projects = paginate_index(Project.all)
  end

  def myproject
    @projects = paginate_index(current_user.projects)
  end

  def new
    @project = current_user.projects.build
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to :myproject, notice: t('notice.create_new_project')
    else

      render :new
    end
  end

  private

  def paginate_index(projects)
    project_count_on_first_page = 8
    project_count_on_each_ajax = 9
    paginates_per = request.xhr? ? project_count_on_each_ajax : project_count_on_first_page
    projects.reverse_order.page(params[:page]).per(paginates_per)
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
