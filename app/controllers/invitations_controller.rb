class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_project, only: %i[create]
  before_action :find_invitaion, only: %i[accept]

  def create
    user = User.find(params[:user_id])
    invitation = user.invitations.build(project_id: @project.id)
    authorize! invitation
    invitation.user = current_user
    invitation.save
    redirect_to invite_project_path(@project)
  end

  def accept
    authorize! @invitaion
    @invitaion.update(accept: true)
    redirect_to notification_path
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def find_invitaion
    @invitaion = Invitation.find(params[:id])
  end
end
