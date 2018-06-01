require 'rails_helper'

RSpec.feature 'Projects', type: :feature do
  describe 'new user who is not registered with Twitter' do
    describe 'authentication denied' do
      it 'denies access to projects_path' do
        visit projects_path
        expect(page).to have_content 'ログインまたは登録が必要です。'
      end
    end
    describe 'project host user operation' do
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
    describe 'project guest user operation' do
      set_twitter_mock_auth
      before do
        visit 'users/auth/twitter'
        @project = create(:project)
      end
      describe 'user not having invitaion' do
        it 'fails to a project detail view' do
          visit root_path
          click_link 'firstPJ'
          expect(page).to have_content '権限がありません'
        end
        it 'fails to a project edit view' do
          visit edit_project_path(@project)
          expect(page).to have_content '権限がありません'
        end
      end
      describe 'user having invitaion' do
        it 'fails to a project edit view' do
          current_user = User.find_by(name: 'yutoJ')
          create(:invitation, project: @project, invitee: current_user, accept: true)
          visit root_path
          click_link 'firstPJ'
          expect(page).to have_content 'firstPJ'
          expect(page.has_link?('firstPJ')).to be_falsey
        end
      end
    end
  end
end
