class PagesController < ApplicationController
  before_action :authenticate_user!, only: %i[notification]
  def login
    redirect_to root_path if user_signed_in?
  end

  def notification
    @invitations = current_user.invitations.includes(:project, project: :user).reverse_order.page(params[:page]).per(5)
  end
end
