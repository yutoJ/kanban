class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: %i[index myproject create new]
  def index
    @projects = Project.paginate_index(Project.all, params[:page], request.xhr?)
  end

  def myproject
    @projects = Project.paginate_index(current_user.projects, params[:page], request.xhr?)
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

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
