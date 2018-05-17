class Users::RegistrationsController < Devise::RegistrationsController # rubocop:disable Style/ClassAndModuleChildren
  def destroy
    if current_user.host_projects.present?
      current_user.delegate_host_projects_auth
      current_user.reload
    end
    super
  end
end
