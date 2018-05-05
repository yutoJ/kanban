class User < ApplicationRecord
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: %i[facebook twitter github]
  has_many :host_projects, dependent: :destroy, class_name: 'Project'
  has_many :cards, dependent: :nullify, class_name: 'Card', foreign_key: 'assignee_id'
  has_many :project_members, foreign_key: 'member_id', dependent: :destroy
  has_many :projects, through: :project_members

  mount_uploader :sns_image, SnsImageUploader

  scope :fuzzy_search, ->(name) { where('name LIKE(?)', "%#{name}%") }

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
