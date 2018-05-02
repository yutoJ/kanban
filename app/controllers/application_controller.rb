class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def my_project?(project)
    current_user.id == project.user_id
  end
end
