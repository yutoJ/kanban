class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_column, only: %i[new create]
  before_action :set_card, only: %i[edit update destroy move]

  def new
    authorize! @column.project
    @card = @column.cards.build
    @card.project_id = @column.project_id
  end

  def create
    authorize! @column.project
    @card = Card.new(card_params)
    if @card.save
      redirect_to project_path(@card.project_id), notice: t('notice.add_new_card')
    else
      render :new
    end
  end

  def edit
    authorize! @card.column.project
  end

  def update
    authorize! @card.column.project
    if @card.update(card_params)
      redirect_to project_path(@card.project), notice: t('notice.update_card')
    else
      render :edit
    end
  end

  def destroy
    authorize! @card.column.project
    @card.destroy
    redirect_to project_path(@card.project), notice: t('notice.delete_card')
  end

  def move
    column = Column.find_by(id: params[:to])
    authorize! column.project
    return redirect_to project_path(@card.project), notice: t('notice.no_column') if column.blank?
    @card.update(column_id: column.id)
    redirect_to project_path(@card.project)
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

  def set_card
    @card = Card.find(params[:id])
  end
end
