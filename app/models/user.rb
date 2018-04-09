class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :rememberable, :trackable, :omniauthable, omniauth_providers: %i[facebook twitter github]

  def self.find_for_auth(auth)
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user
  end

  def self.create_fb_auth(auth)
    user = User.create(
      name:      auth.extra.raw_info.name,
      uid:       auth.uid,
      provider:  auth.provider,
      email:     auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
      sns_image: auth.info.image,
      password:  Devise.friendly_token[0, 20]
    )
    user
  end

  def self.create_tw_auth(auth)
    user = User.create(
      name:      auth.info.nickname,
      uid:       auth.uid,
      provider:  auth.provider,
      email:     auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
      sns_image: auth.info.image,
      password:  Devise.friendly_token[0, 20]
    )
    user
  end

  def self.create_gh_auth(auth)
    user = User.create(
      name:      auth.info.nickname,
      uid:       auth.uid,
      provider:  auth.provider,
      email:     auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
      sns_image: auth.info.image,
      password:  Devise.friendly_token[0, 20]
    )
    user
  end
end
