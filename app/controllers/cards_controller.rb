class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_column, only: %i[new create]
  before_action :set_card, only: %i[edit update destroy move]
  before_action :check_owner

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

  def edit
    # only before action
  end

  def update
    if @card.update(card_params)
      redirect_to project_path(@card.project), notice: t('notice.update_card')
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to project_path(@card.project), notice: t('notice.delete_card')
  end

  def move
    return redirect_to project_path(@card.project), notice: t('notice.no_column') unless Column.exists?(params[:id])
    @card.column_id = params[:id]
    @card.save
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

  def check_owner
    if @column.present?
      redirect_to :myproject, notice: t('notice.not_owner') unless my_project?(@column.project)
    elsif @card.present?
      redirect_to :myproject, notice: t('notice.not_owner') unless my_project?(@card.project)
    end
  end
end
