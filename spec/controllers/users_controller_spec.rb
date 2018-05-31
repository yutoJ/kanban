require 'rails_helper'

describe UsersController do
  describe 'all path' do
    context 'with auth' do
      login
      it 'updates instance' do
        users_params = { name: 'yutoJ' }
        put :update, params: { id: user.id, user: users_params }
        expect(User.find(user.id).name).to eq users_params[:name]
        expect(response).to redirect_to(mypage_path)
      end

      it 'opens mypage' do
        get :mypage
        expect(response).to render_template :mypage
      end
    end
  end
end
