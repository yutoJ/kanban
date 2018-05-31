require 'rails_helper'

describe PagesController do
  describe 'all path' do
    context 'without auth' do
      it 'opens login view' do
        get :login
        expect(response).to render_template :login
      end
    end
    context 'with auth' do
      login
      it 'opens login view' do
        get :login
        expect(response).to redirect_to(root_path)
      end

      it 'opens notifications view' do
        projects = Array.new(2) { create(:project, user: user) }
        invitations = projects.map { |project| create(:invitation, project_id: project.id, invitee_id: user.id) }
        get :notification
        expect(assigns(:invitations)).to eq invitations.reverse
      end
    end
  end
end
