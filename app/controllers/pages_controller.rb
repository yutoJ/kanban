class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    @projects = Project.all
  end

  def login
    # nothing
  end

  def mypage
    # nothing
  end
end
