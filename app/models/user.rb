class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable, :rememberable, :trackable, :omniauthable, omniauth_providers: [:facebook, :twitter]

  def self.find_or_create_fb_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create(
        name:      auth.extra.raw_info.name,
        uid:       auth.uid,
        provider:  auth.provider,
        email:     auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
        sns_image: auth.info.image,
        password:  Devise.friendly_token[0, 20]
      )
    end
    user
  end

  def self.find_or_create_tw_oauth(auth)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.new(
        name:      auth.info.nickname,
        uid:       auth.uid,
        provider:  auth.provider,
        email:     auth.info.email ||= "#{auth.uid}-#{auth.provider}@example.com",
        sns_image: auth.info.image,
        password:  Devise.friendly_token[0, 20]
      )
    end
    user.save
    user
  end
end
