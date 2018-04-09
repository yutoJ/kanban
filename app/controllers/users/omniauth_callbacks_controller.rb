class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController # rubocop:disable Style/ClassAndModuleChildren
  def facebook
    callback_from 'facebook'
  end

  def twitter
    callback_from 'twitter'
  end

  private

  def callback_from(provider)
    auth = request.env['omniauth.auth']
    @user = User.find_for_auth(auth)
    if @user
      set_flash_message(:notice, :signed_in) if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
      return
    end
    @user = create_auth_acount(auth)
    if @user.persisted?
      set_flash_message(:notice, :signed_up, kind: provider.capitalize) if is_navigational_format?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = auth
      redirect_to login_path
    end
  end

  def create_auth_acount(auth)
    user = User.create_fb_auth(auth) if auth.provider == 'facebook'
    user = User.create_tw_auth(auth) if auth.provider == 'twitter'
    user
  end
end
