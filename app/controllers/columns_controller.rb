class ColumnsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: %i[new create]
  before_action :column_params, only: %i[create]

  def new
    @column = @project.columns.build
  end

  def create
    @column = @project.columns.build(column_params)
    if @project.save
      flash[:notice] = I18n.t('notice.add_new_column')
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
    # only before action
  end

  private

  def column_params
    params.require(:column).permit(:name)
  end

  def find_project
    @project = Project.find(params[:id])
  end
end
