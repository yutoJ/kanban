class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_column, only: %i[new create move]
  before_action :set_card, only: %i[edit update destroy move]
  before_action :check_auth

  def new
    @card = @column.cards.build
    @card.project_id = @column.project_id
    @members = @column.project.members
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      ProjectLog.add_log(params[:controller], params[:action], current_user, @column.project)
      redirect_to project_path(@card.project_id), notice: t('notice.add_new_card')
    else
      render :new
    end
  end

  def edit
    @members = @card.project.members
  end

  def update
    @card.assign_attributes(card_params)
    change_assign = @card.changed.include?("assignee_id")
    if @card.save
      ProjectLog.add_assign_log(params[:controller], current_user, @card) if change_assign
      ProjectLog.add_log(params[:controller], params[:action], current_user, @card.column.project) unless change_assign
      redirect_to project_path(@card.project), notice: t('notice.update_card')
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    ProjectLog.add_log(params[:controller], params[:action], current_user, @card.column.project)
    redirect_to project_path(@card.project), notice: t('notice.delete_card')
  end

  def move
    return redirect_to project_path(@card.project), notice: t('notice.no_column') if @column.blank?
    @card.update(column_id: @column.id)
    ProjectLog.add_move_card_log(params[:controller], params[:action], current_user, @card)
    redirect_to project_path(@card.project)
  end

  private

  def find_column
    if params[:column_id].present?
      @column = Column.find(params[:column_id])
    elsif params[:card][:column_id].present?
      @column = Column.find(params[:card][:column_id])
    elsif params[:to].present?
      @column = Column.find(params[:to])
    end
  end

  def card_params
    params.require(:card).permit(:name, :due_date, :assignee_id, :project_id, :column_id)
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def check_auth
    if @column.present?
      authorize! @column.project
    elsif @card.present?
      authorize! @card.column.project
    end
  end
end
