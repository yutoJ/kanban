class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: %i[create]
  before_action :check_owner, only: %i[create]

  def create
    user = User.find(params[:user_id])
    invitation = user.invitations.build(project_id: @project.id)
    invitation.save
    redirect_to invite_project_path(@project)
  end

  def accept
    invitaion = Invitation.find(params[:id])
    invitaion.update(accept: true)
    redirect_to notification_path
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def check_owner
    redirect_to :myproject, alert: t('errors.messages.not_authorized') unless my_project?(@project)
  end
end
