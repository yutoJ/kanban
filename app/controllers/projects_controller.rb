class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[show edit update destroy invite logs]
  before_action :check_auth, only: %i[show edit update destroy invite logs]
  before_action :project_params, only: %i[create update]

  def index
    @projects = Project.paginate_index(Project.all, params[:page], request.xhr?)
  end

  def myproject
    @projects = Project.paginate_myprojects_index(current_user.my_projects, params[:page], request.xhr?)
  end

  def new
    @project = current_user.host_projects.build
  end

  def create
    @project = current_user.host_projects.build(project_params)
    if @project.save
      redirect_to :myproject, notice: t('notice.create_new_project')
    else
      render :new
    end
  end

  def edit
    # only before action
  end

  def update
    if @project.update(project_params)
      redirect_to :myproject, notice: t('notice.update_project')
    else
      render :edit
    end
  end

  def show
    @columns, @positions = ColumnPosition.sort_by_sequence_num(@project.columns)
  end

  def destroy
    @project.destroy
    redirect_to :myproject, notice: t('notice.delete_project')
  end

  def invite
    @users = request.xhr? ? User.fuzzy_search(params[:search]) : User.all.reject { |u| u == current_user }
  end

  def logs
    @logs = ProjectLog.paginate_index(@project, params[:page])
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def check_auth
    authorize! @project
  end
end
