class User < ApplicationRecord
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: %i[facebook twitter github]

  mount_uploader :sns_image, SnsImageUploader

  def self.find_for_auth(auth)
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user
  end

  def self.create_fb_auth(auth)
    user = User.create(
      name:      auth.extra.raw_info.name,
      uid:       auth.uid,
      provider:  auth.provider,
      remote_sns_image_url: auth.info.image
    )
    user
  end

  def self.create_tw_auth(auth)
    user = User.create(
      name:      auth.info.nickname,
      uid:       auth.uid,
      provider:  auth.provider,
      remote_sns_image_url: auth.info.image
    )
    user
  end

  def self.create_gh_auth(auth)
    user = User.create(
      name:      auth.info.nickname,
      uid:       auth.uid,
      provider:  auth.provider,
      remote_sns_image_url: auth.info.image
    )
    user
  end
end
