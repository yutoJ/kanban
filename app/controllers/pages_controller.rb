class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    # nothing
  end

  def login
    # nothing
  end

  def mypage
    # nothing
  end
end
