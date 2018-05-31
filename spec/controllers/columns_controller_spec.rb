require 'rails_helper'

describe ColumnsController do
  describe 'all path' do
    context 'with auth' do
      login
      before do
        @project = create(:project, user: user)
      end
      it 'creates new column instance' do
        get :new, params: { project_id: @project.id }
        expect(assigns(:column)).to be_a_new Column
      end

      it 'creates new column' do
        column_params = { name: 'first' }
        post :create, params: { project_id: @project.id, column: column_params }
        expect(Column.last.name).to eq column_params[:name]
        expect(response).to redirect_to(project_path(Column.last.project))
      end

      it 'fails to create an invalid column' do
        column_params = { name: '' }
        post :create, params: { project_id: @project.id, column: column_params }
        expect(response).to render_template :new
      end

      it 'edit new column' do
        column = create(:column, project: @project)
        get :edit, params: { project_id: column.project.id, id: column.id }
        expect(assigns(:column)).to eq column
      end

      it 'updates a project' do
        column = create(:column, project: @project)
        column_params = { name: 'second' }
        put :update, params: { project_id: column.project.id, id: column.id, column: column_params }
        expect(assigns(:column).name).to eq column_params[:name]
        expect(assigns(:column)).to eq Column.find(column.id)
        expect(response).to redirect_to(project_path(column.project))
      end

      it 'fails to update an invalid project' do
        column = create(:column, project: @project)
        column_params = { name: '' }
        put :update, params: { project_id: column.project.id, id: column.id, column: column_params }
        expect(response).to render_template :edit
      end

      it 'destroys a project' do
        column = create(:column, project: @project)
        delete :destroy, params: { project_id: column.project.id, id: column.id }
        expect(Column.exists?(column.id).nil?).to be_falsey
        expect(response).to redirect_to(project_path(column.project))
      end
    end
  end
end
