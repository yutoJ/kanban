class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: %i[show destroy]
  before_action :check_owner, only: %i[show edit update destroy]
  before_action :project_params, only: %i[create update]

  def index
    paginates_per = request.xhr? ? 9 : 8
    @projects = Project.all.reverse_order.page(params[:page]).per(paginates_per)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def myproject
    paginates_per = request.xhr? ? 9 : 8
    @projects = current_user.projects.reverse_order.page(params[:page]).per(paginates_per)
    respond_to do |format|
      format.html
      format.js
    end
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

  def show
    # only before action
  end

  def destroy
    @project.destroy
    redirect_to :myproject, notice: t('notice.delete_project')
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def check_owner
    return if my_project?
    redirect_to :myproject, notice: t('notice.not_owner')
  end

  def my_project?
    set_project
    current_user.id == @project.user_id
  end
end
