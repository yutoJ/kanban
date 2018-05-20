require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  describe 'Validation' do
    it 'name is necessary' do
      invalid_model = FactoryBot.build(:user, name: nil)
      expect(invalid_model.save).to be_falsey
    end

    it 'uid is necessary' do
      invalid_model = FactoryBot.build(:user, uid: nil)
      expect(invalid_model.save).to be_falsey
    end
  end

  describe 'instance methods' do
    it 'my_projects' do
      user = FactoryBot.create(:user)
      FactoryBot.create(:project, user: user)
      FactoryBot.create(:invitation, invitee: user, accept: false)
      FactoryBot.create(:invitation, invitee: user, accept: true)
      projects = user.my_projects
      expect(projects.count).to eq 2
    end

    it 'delegate_host_projects_auth' do
      user = FactoryBot.create(:user)
      member = FactoryBot.create(:user)
      project = FactoryBot.create(:project, user: user)
      FactoryBot.create(:invitation, project: project, invitee: member, accept: true)
      expect(user.host_projects[0]).to eq project
      user.delegate_host_projects_auth
      expect(user.host_projects).to be_empty
      expect(member.host_projects[0]).to eq project
    end
  end
end
