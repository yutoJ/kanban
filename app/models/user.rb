class User < ApplicationRecord
  devise :rememberable, :trackable, :omniauthable, omniauth_providers: %i[facebook twitter github]
  has_many :host_projects, dependent: :destroy, class_name: 'Project'
  has_many :cards, dependent: :nullify, class_name: 'Card', foreign_key: 'assignee_id'
  has_many :invitations, foreign_key: 'invitee_id', dependent: :destroy

  mount_uploader :sns_image, SnsImageUploader

  scope :fuzzy_search, ->(name) { where('name LIKE(?)', "%#{name}%") }

  def my_projects
    attending_project_ids = invitations.where(accept: true).map(&:project_id)
    host_project_ids = host_projects.map(&:id)
    my_project_ids = attending_project_ids + host_project_ids
    Project.find(my_project_ids)
  end

  def delegate_host_projects_auth
    host_projects.map do |project|
      project.update(user_id: project.members[1].id) if project.members[1].present?
    end
  end

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
