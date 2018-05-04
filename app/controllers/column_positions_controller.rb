class ColumnPositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_column_position, only: %i[update]
  before_action :check_owner, only: %i[update]

  def update
    redirect_to @current_position.column.project if @current_position.change_position(params[:move_to])
  end

  private

  def set_column_position
    @current_position = ColumnPosition.find(params[:id])
  end

  def check_owner
    redirect_to :myproject, notice: t('notice.not_owner') unless my_project?(@current_position.column.project)
  end
end
