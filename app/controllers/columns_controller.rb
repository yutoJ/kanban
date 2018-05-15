class ColumnsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: %i[new create]
  before_action :set_columns, only: %i[edit update destroy]
  before_action :check_auth

  def new
    @column = @project.columns.build
  end

  def create
    @column = @project.columns.build(column_params)
    if @column.save_with_column_position
      ProjectLog.add_log(params[:controller], params[:action], current_user, @project)
      redirect_to project_path(@project), notice: t('notice.create_column')
    else
      render :new
    end
  end

  def edit
    # only before action
  end

  def update
    if @column.update(column_params)
      ProjectLog.add_log(params[:controller], params[:action], current_user, @column.project)
      redirect_to project_path(@column.project), notice: t('notice.update_column')
    else
      render :edit
    end
  end

  def destroy
    @column.destroy
    ProjectLog.add_log(params[:controller], params[:action], current_user, @column.project)
    redirect_to project_path(@column.project), notice: t('notice.delete_column')
  end

  private

  def column_params
    params.require(:column).permit(:name, :project_id)
  end

  def find_project
    @project = Project.find(params[:project_id])
  end

  def set_columns
    @column = Column.find(params[:id])
  end

  def check_auth
    if @project.present?
      authorize! @project
    elsif @column.present?
      authorize! @column.project
    end
  end
end
