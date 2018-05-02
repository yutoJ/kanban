class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def new_session_path(_scope)
    root_path
  end

  def my_project?(project)
    current_user.id == project.user_id
  end
end
