require 'rails_helper'

RSpec.feature 'Projects', type: :feature do
  describe 'new user who is not registered with Twitter' do
    describe 'authentication success' do
      set_twitter_mock_auth
      before do
        visit 'users/auth/twitter'
      end
      it 'should add an item by the user' do
        visit root_path
        page.should have_content('新しいプロジェクトを作成')
      end
    end
  end
end
