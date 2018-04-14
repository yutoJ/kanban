class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController # rubocop:disable Style/ClassAndModuleChildren
  def facebook
    callback_from 'facebook'
  end

  def twitter
    callback_from 'twitter'
  end

  private

  def callback_from(provider)
    @user = User.find_or_create_fb_oauth(request.env['omniauth.auth']) if provider == 'facebook'
    @user = User.find_or_create_tw_oauth(request.env['omniauth.auth']) if provider == 'twitter'
    if @user.persisted?
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      redirect_to login_path
    end
  end
end
