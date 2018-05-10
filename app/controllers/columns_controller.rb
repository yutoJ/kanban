class ColumnsController < ApplicationController
  before_action :authenticate_user!
  before_action :column_params, only: %i[create update]
  before_action :find_project, only: %i[new create]
  before_action :set_columns, only: %i[edit update destroy]

  def new
    authorize! @project
    @column = @project.columns.build
  end

  def create
    authorize! @project
    @column = @project.columns.build(column_params)
    if @column.save_with_column_position
      redirect_to project_path(@project), notice: t('notice.add_new_column')
    else
      render :new
    end
  end

  def edit
    authorize! @column.project
  end

  def update
    authorize! @column.project
    if @column.update(column_params)
      redirect_to project_path(@column.project), notice: t('notice.update_column')
    else
      render :edit
    end
  end

  def destroy
    authorize! @column.project
    @column.destroy
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
end
