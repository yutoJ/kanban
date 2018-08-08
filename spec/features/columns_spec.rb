require 'rails_helper'

RSpec.feature 'Columns', type: :feature do
  describe 'new user who is not registered with Twitter' do
    describe 'project host user operation' do
      set_twitter_mock_auth
      before do
        visit 'users/auth/twitter'
        @current_user = User.find_by(name: 'yutoJ')
        @project = create(:project, user: @current_user)
        visit project_path(@project)
        click_link 'カラムを追加'
        fill_in 'column[name]', with: 'RIGHT'
        click_button '作成'
      end
      it 'creates a column' do
        expect do
          expect(page).to have_content 'RIGHT'
          expect(@project.reload.columns.count).to eq 1
        end
      end

      it 'edits the column' do
        click_link 'RIGHT'
        fill_in 'column[name]', with: 'BIG'
        expect do
          click_button '更新'
          expect(page).to have_content 'BIG'
          expect(page).not_to have_content 'RIGHT'
        end
      end

      it 'deletes the column' do
        click_link 'RIGHT'
        expect do
          click_button '削除'
          expect(page).not_to have_content 'RIGHT'
        end
      end

      it 'moves the column' do
        left_column = create(:column, name: 'LEFT', project: @project)
        visit current_path
        expect(left_column.column_position.sequence_num).to eq 2
        within(all('.card-header')[0]) do
          click_link '→'
        end
        expect(left_column.reload.column_position.sequence_num).to eq 1
        within(all('.card-header')[1]) do
          click_link '←'
        end
        expect(left_column.reload.column_position.sequence_num).to eq 2
      end
    end
  end
end
