class PagesController < ApplicationController
  before_action :authenticate_user!, only: %i[notification]
  def login
    # nothing
  end

  def mypage
    # nothing
  end

  def notification
    # nothing
  end
end
