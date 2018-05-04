module ApplicationHelper
  def my_project?(project)
    current_user.id == project.user_id
  end
end
