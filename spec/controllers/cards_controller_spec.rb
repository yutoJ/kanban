require 'rails_helper'

describe CardsController do
  describe 'all path' do
    context 'with auth' do
      login
      before do
        project = create(:project, user: user)
        @column = create(:column, project: project)
      end
      it 'creates new card instance' do
        get :new, params: { column_id: @column.id }
        expect(assigns(:card)).to be_a_new Card
      end

      it 'creates new card' do
        cards_params = { name: 'first', project_id: @column.project_id, column_id: @column.id }
        post :create, params: { card: cards_params }
        expect(Card.last.name).to eq cards_params[:name]
        expect(response).to redirect_to(project_path(@column.project))
      end

      it 'fails to create an invalid card' do
        cards_params = { name: '' }
        post :create, params: { column_id: @column.id, card: cards_params }
        expect(response).to render_template :new
      end

      it 'edit new card' do
        card = create(:card, column: @column)
        get :edit, params: { id: card.id }
        expect(assigns(:card)).to eq card
      end

      it 'updates a card' do
        card = create(:card, column: @column)
        cards_params = { name: 'second' }
        put :update, params: { id: card.id, card: cards_params }
        expect(assigns(:card).name).to eq cards_params[:name]
        expect(assigns(:card)).to eq Card.find(card.id)
        expect(response).to redirect_to(project_path(@column.project))
      end

      it 'fails to update an invalid card' do
        card = create(:card, column: @column)
        cards_params = { name: '' }
        put :update, params: { id: card.id, card: cards_params }
        expect(response).to render_template :edit
      end

      it 'destroys a card' do
        card = create(:card, column: @column)
        delete :destroy, params: { id: card.id }
        expect(Card.exists?(card.id).nil?).to be_falsey
        expect(response).to redirect_to(project_path(@column.project))
      end

      it 'moves card to another column' do
        card = create(:card, column: @column)
        another_column = create(:column, project_id: @column.project_id)
        get :move, params: { id: card.id, to: another_column.id }
        expect(assigns(:card).column).to eq another_column
        expect(response).to redirect_to(project_path(@column.project))
      end
    end
  end
end
