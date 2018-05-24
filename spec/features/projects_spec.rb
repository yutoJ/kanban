require 'rails_helper'

RSpec.feature 'Projects', type: :feature do
  describe 'new user who is not registered with Twitter' do
    describe 'authentication success' do
      set_twitter_mock_auth
      before do
        visit 'users/auth/twitter'
      end
      it 'creates a project' do
        visit root_path
        click_link '新しいプロジェクトを作成'
        fill_in 'project[name]', with: 'firstPJ'
        fill_in 'project[description]', with: 'sample'
        expect do
          click_button '作成'
          expect(page).to have_content 'firstPJ'
        end.to change(Project, :count).by(1)
      end
      it 'edits a project' do
        current_user = User.find_by(name: 'yutoJ')
        project = create(:project, user: current_user)
        visit project_path(project)
        click_link 'firstPJ'
        fill_in 'project[name]', with: 'changePJ'
        expect do
          click_button '更新'
          expect(page).to have_content 'changePJ'
          expect(page).not_to have_content 'firstPJ'
        end
      end
      it 'deletes a project' do
        current_user = User.find_by(name: 'yutoJ')
        project = create(:project, user: current_user)
        visit project_path(project)
        click_link 'firstPJ'
        expect do
          click_button '削除'
          expect(page).not_to have_content 'firstPJ'
        end
      end
    end
  end
end
