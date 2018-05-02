class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_column, only: %i[new]

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
    @column = Column.find(params[:column_id])
  end

  def card_params
    params.require(:card).permit(:name, :due_date, :assignee_id, :project_id, :column_id)
  end
end
