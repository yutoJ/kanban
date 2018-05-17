class ColumnPositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_column_position, only: %i[update]

  def update
    authorize! @current_position.column.project
    redirect_to project_path(@current_position.column.project) if @current_position.change_position(params[:move_to])
  end

  private

  def set_column_position
    @current_position = ColumnPosition.find(params[:id])
  end
end
