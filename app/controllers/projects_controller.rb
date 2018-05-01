class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[edit update destroy]
  before_action :check_owner, only: %i[edit update destroy]
  before_action :project_params, only: %i[create update]

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

  def destroy
    @project.destroy
    flash[:notice] = I18n.t('notice.delete_project')
    redirect_to :myproject
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def my_project?(project)
    current_user.id == project.user_id
  end

  def check_owner
    redirect_to :myproject, notice: t('notice.not_owner') unless my_project?(@project)
  end
end
