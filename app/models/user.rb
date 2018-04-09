class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :rememberable, :trackable, :omniauthable, omniauth_providers: %i[facebook twitter]

  def self.find_or_create_fb_oauth(auth)
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.create(
      name:      auth.extra.raw_info.name,
      uid:       auth.uid,
      provider:  auth.provider,
      sns_image: auth.info.image
    )
    user
  end

  def self.find_or_create_tw_oauth(auth)
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.create(
      name:      auth.info.nickname,
      uid:       auth.uid,
      provider:  auth.provider,
      sns_image: auth.info.image
    )
    user
  end
end
