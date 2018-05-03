module ApplicationHelper
  def date_japan(time)
    time.strftime('%m月%d日')
  end

  def my_project?(project)
    current_user.id == project.user_id
  end
end
