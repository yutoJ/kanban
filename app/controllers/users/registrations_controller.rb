class Users::RegistrationsController < Devise::RegistrationsController
  def destroy
    if current_user.host_projects.present?
      current_user.delegate_host_projects_auth
      current_user.reload
    end
    super
  end
end
