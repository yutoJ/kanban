require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) { create(:project) }
  describe 'Validation' do
    it 'name is necessary' do
      invalid_model = build(:project, name: nil)
      expect(invalid_model.save).to be_falsey
    end

    it 'name character size limit is over' do
      invalid_model = build(:project, name: 'a' * 141)
      expect(invalid_model.save).to be_falsey
    end

    it 'description character size limit is over' do
      invalid_model = build(:project, description: 'a' * 301)
      expect(invalid_model.save).to be_falsey
    end

    it 'A project is not related with a user' do
      invalid_model = build(:project, user_id: nil)
      expect(invalid_model.save).to be_falsey
    end
  end

  describe 'class method' do
    it 'paginate_index' do
      projects = [*(1..9)].map { |n| create(:project) }
      expect(Project.paginate_myprojects_index(projects, 1, true).count).to eq 9
      expect(Project.paginate_myprojects_index(projects, 2, true).count).to eq 0
      expect(Project.paginate_myprojects_index(projects, 1, false).count).to eq 8
      expect(Project.paginate_myprojects_index(projects, 2, false).count).to eq 1
    end

    it 'paginate_myprojects_index' do
      host = create(:user)
      projects = [*(1..9)].map { |n| create(:project, user: host) }
      expect(Project.paginate_myprojects_index(projects, 1, true).count).to eq 9
      expect(Project.paginate_myprojects_index(projects, 2, true).count).to eq 0
      expect(Project.paginate_myprojects_index(projects, 1, false).count).to eq 8
      expect(Project.paginate_myprojects_index(projects, 2, false).count).to eq 1
    end
  end

  describe 'instance method' do
    it 'members' do
      host = create(:user)
      project = create(:project, user: host)
      create(:invitation, project: project, accept: true)
      create(:invitation, project: project, accept: true)
      create(:invitation, project: project, accept: false)
      expect(project.members.count).to eq 3
    end
  end
end
