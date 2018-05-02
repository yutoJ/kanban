class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_column, only: %i[new create]
  before_action :check_owner, only: %i[new create]

  def new
    @card = @column.cards.build
    @card.project_id = @column.project_id
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to project_path(@card.project_id), notice: t('notice.add_new_card')
    else
      render :new
    end
  end

  private

  def find_column
    if params[:column_id].present?
      @column = Column.find(params[:column_id])
    elsif params[:card][:column_id].present?
      @column = Column.find(params[:card][:column_id])
    end
  end

  def card_params
    params.require(:card).permit(:name, :due_date, :assignee_id, :project_id, :column_id)
  end

  def check_owner
    redirect_to :myproject, notice: t('notice.not_owner') unless my_project?(@column.project)
  end
end
