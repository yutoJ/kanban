class ProjectMembersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: %i[create]
  before_action :check_owner, only: %i[create]

  def create
    user = User.find(params[:user_id])
    project_member = user.project_members.build(project_id: @project.id)
    project_member.save
    redirect_to invite_project_path(@project)
  end

  def accept
    # D01-5 accept
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def check_owner
    redirect_to :myproject, notice: t('notice.not_owner') unless my_project?(@project)
  end
end
