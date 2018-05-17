class ApplicationController < ActionController::Base
  include Banken
  protect_from_forgery with: :exception

  def new_session_path(_scope)
    root_path
  end

  def my_project?(project)
    current_user.id == project.user_id
  end

  rescue_from Banken::NotAuthorizedError, with: :user_not_authorized

  def user_not_authorized
    redirect_to myproject_path, alert: t('errors.messages.not_authorized')
  end
end
