class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: %i[index myproject create new]
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
      flash[:notice] = I18n.t('notice.create_new_project')
      redirect_to :myproject
    else

      render :new
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
