class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController # rubocop:disable Style/ClassAndModuleChildren
  def facebook
    callback_from :facebook
  end

  def twitter
    callback_from :twitter
  end

  private

  def callback_from(provider)
    provider = provider.to_s
    if provider == 'facebook' then @user = User.find_or_create_fb_oauth(request.env['omniauth.auth']) end
    if provider == 'twitter' then @user = User.find_or_create_tw_oauth(request.env['omniauth.auth']) end
    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to login_path
    end
  end
end
