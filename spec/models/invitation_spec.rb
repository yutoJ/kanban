require 'rails_helper'

RSpec.describe Invitation, type: :model do
  let(:invitation) { FactoryBot.create(:invitation) }
  describe 'Validation' do
    it 'A invitation is not related with a user' do
      invalid_model = FactoryBot.build(:invitation, invitee_id: nil)
      expect(invalid_model.save).to be_falsey
    end

    it 'A invitation is not related with a project' do
      invalid_model = FactoryBot.build(:invitation, project_id: nil)
      expect(invalid_model.save).to be_falsey
    end
  end
end
