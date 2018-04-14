class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:mypage]
  before_action :user_params, only: [:update]

  def update
    current_user.update(user_params)
    redirect_to :mypage
  end

  def mypage
    # nothing to do
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
