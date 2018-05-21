require 'rails_helper'

RSpec.describe ProjectLog, type: :model do
  let(:project_log) { create(:project_log) }
  describe 'Validation' do
    it 'project_id is necessary' do
      invalid_model = build(:project_log, project_id: nil)
      expect(invalid_model.save).to be_falsey
    end
  end

  describe 'class method' do
    it 'paginate_index' do
      project = create(:project)
      6.times { create(:column, project: project) }

      expect(ProjectLog.paginate_index(project, 1).count).to eq 5
      expect(ProjectLog.paginate_index(project, 2).count).to eq 1
      expect(ProjectLog.paginate_index(project, 3).count).to eq 0
    end
  end
end
