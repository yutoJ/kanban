class PagesController < ApplicationController
  before_action :authenticate_user!, only: %i[notification]
  def login
    # nothing
  end

  def mypage
    # nothing
  end

  def notification
    @invitations = current_user.invitations.reverse_order.page(params[:page]).per(5)
  end
end
