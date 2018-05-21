require 'rails_helper'

RSpec.describe Column, type: :model do
  describe 'Validation' do
    it 'name is necessary' do
      invalid_model = build(:column, name: nil)
      expect(invalid_model.save).to be_falsey
    end

    it 'name character size limit is over' do
      invalid_model = build(:column, name: 'a' * 41)
      expect(invalid_model.save).to be_falsey
    end

    it 'A column is not related with a project' do
      invalid_model = build(:column, project_id: nil)
      expect(invalid_model.save).to be_falsey
    end
  end
end
