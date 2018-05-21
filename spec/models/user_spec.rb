require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  describe 'Validation' do
    it 'name is necessary' do
      invalid_model = build(:user, name: nil)
      expect(invalid_model.save).to be_falsey
    end

    it 'uid is necessary' do
      invalid_model = build(:user, uid: nil)
      expect(invalid_model.save).to be_falsey
    end
  end

  describe 'instance methods' do
    it 'my_projects' do
      user = create(:user)
      create(:project, user: user)
      create(:invitation, invitee: user, accept: false)
      create(:invitation, invitee: user, accept: true)
      projects = user.my_projects
      expect(projects.count).to eq 2
    end

    it 'delegate_host_projects_auth' do
      user = create(:user)
      member = create(:user)
      project = create(:project, user: user)
      create(:invitation, project: project, invitee: member, accept: true)
      expect(user.host_projects[0]).to eq project
      user.delegate_host_projects_auth
      expect(user.host_projects).to be_empty
      expect(member.host_projects[0]).to eq project
    end
  end
end
