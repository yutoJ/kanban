require 'rails_helper'

RSpec.describe ProjectLog, type: :model do
  let(:project_log) { FactoryBot.create(:project_log) }
  describe 'Validation' do
    it 'project_id is necessary' do
      invalid_model = FactoryBot.build(:project_log, project_id: nil)
      expect(invalid_model.save).to be_falsey
    end
  end
end
