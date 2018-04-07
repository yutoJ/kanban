class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_from :facebook
  end

  private

  def callback_from(provider)
    provider = provider.to_s

    @user = User.find_or_create_fb_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      # sign_in_and_redirect @user, event: :authentication
    else
      #session["devise.#{provider}_data"] = request.env['omniauth.auth']
      #redirect_to new_user_registration_url
      #flash[:notice] = I18n.t('devise.omniauth_callbacks.failuew', kind: provider.capitalize)
      redirect_to root_path
    end
  end
end
