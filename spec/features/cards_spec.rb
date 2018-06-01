require 'rails_helper'

RSpec.feature 'Cards', type: :feature do
  describe 'new user who is not registered with Twitter' do
    describe 'project host user operation' do
      set_twitter_mock_auth
      before do
        visit 'users/auth/twitter'
        @current_user = User.find_by(name: 'yutoJ')
        @project = create(:project, user: @current_user)
        @left_column = create(:column, project: @project)
        visit project_path(@project)
        click_link 'カードを追加'
        fill_in 'card[name]', with: 'TASK'
        click_button '作成'
        @card = Card.find_by(name: 'TASK')
      end
      it 'creates a card' do
        expect do
          expect(page).to have_content 'TASK'
          expect(@project.reload.cards.count).to eq 1
        end
      end

      it 'edits the card' do
        click_link 'TASK'
        fill_in 'card[name]', with: 'ISSUE'
        expect do
          click_button '更新'
          expect(page).to have_content 'ISSUE'
          expect(page).not_to have_content 'TASK'
        end
      end

      it 'deletes the card' do
        click_link 'TASK'
        expect do
          click_button '削除'
          expect(page).not_to have_content 'TASK'
        end
      end

      it 'moves the card' do
        right_column = create(:column, project: @project)
        visit current_path
        expect(@card.column).to eq @left_column
        within(all('.card-body')[0]) do
          find('.fa-arrow-right').click
        end
        expect(@card.reload.column).to eq right_column
        within(all('.card-body')[1]) do
          find('.fa-arrow-left').click
        end
        expect(@card.reload.column).to eq @left_column
      end
    end
  end
end
