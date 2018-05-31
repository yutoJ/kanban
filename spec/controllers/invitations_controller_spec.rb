require 'rails_helper'

describe InvitationsController do
  describe 'all path' do
    context 'with auth' do
      login
      it 'creates invitation' do
        invitee = create(:user, name: 'yutoJ')
        project = create(:project, user: user)
        put :create, params: { project_id: project.id, user_id: invitee.id }
        invitation = Invitation.where(invitee_id: invitee.id, project_id: project.id)
        expect(invitation.count).to eq 1
        actual = project.invitations.select { |i| i.invitee == invitee }
        expect(invitation).to eq actual
        expect(response).to redirect_to(invite_project_path(project))
      end

      it 'accepts invitation' do
        project = create(:project)
        invitation = create(:invitation, project: project, invitee: user)
        expect(invitation.accept).to be_falsey
        get :accept, params: { id: invitation.id }
        expect(assigns(:invitation).accept).to be_truthy
        expect(response).to redirect_to(notification_path)
      end
    end
  end
end
