module ApplicationHelper
  def avatar_url(user)
    if user.profile_image.present?
      user.profile_image
    elsif user.sns_image
      user.sns_image
    end
  end
end
