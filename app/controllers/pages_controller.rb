class PagesController < ApplicationController
  before_action :authenticate_user!, only: %i[notification]
  def login
    # nothing
  end

  def mypage
    # nothing
  end

  def notification
    @projects = current_user.projects.reverse_order.page(params[:page]).per(5)
    @project_members = current_user.project_members
  end
end
