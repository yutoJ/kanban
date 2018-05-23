require 'rails_helper'

describe ProjectsController do
  describe 'GET index' do
    context 'without auth' do
      it 'gets projects list' do
        2.times { create(:project) }
        get :index
        expect(response).to redirect_to(root_path)
      end
    end
    context 'with auth' do
      login
      it 'gets project list' do
        projects = Array.new(2) { create(:project) }
        get :index
        expect(assigns(:projects)).to eq projects.reverse
      end

      it 'gets myproject list' do
        my_projects = Array.new(2) { create(:project, user: user) }
        create(:project)
        get :myproject
        expect(assigns(:projects)).to eq my_projects.reverse
      end

      it 'creates new project instance' do
        get :new
        expect(assigns(:project)).to be_a_new Project
      end

      it 'creates new project' do
        project_params = { name: 'first', description: 'welcome' }
        post :create, params: { project: project_params }
        expect([Project.last.name, Project.last.description]).to eq [project_params[:name], project_params[:description]]
        expect(response).to redirect_to(myproject_path)
      end

      it 'edit new project' do
        project = create(:project, user: user)
        get :edit, params: { id: project.id }
        expect(assigns(:project)).to eq project
      end

      it 'updates a project' do
        project = create(:project, user: user)
        project_params = { name: 'second', description: 'goodbye' }
        put :update, params: { id: project.id, project: project_params }
        expect([assigns(:project).name, assigns(:project).description]).to eq [project_params[:name], project_params[:description]]
        expect(assigns(:project)).to eq Project.find(project.id)
        expect(response).to redirect_to(myproject_path)
      end

      it 'shows a project' do
        project = create(:project, user: user)
        columns = Array.new(2) { create(:column, project: project) }
        positions = columns.map { |column| create(:column_position, column: column) }
        get :show, params: { id: project.id }
        expect(assigns(:project)).to eq project
        expect(assigns(:columns)).to eq columns
        expect(assigns(:positions)).to eq positions
      end

      it 'destroys a project' do
        project = create(:project, user: user)
        delete :destroy, params: { id: project.id }
        expect(Project.exists?(project.id).nil?).to be_falsey
        expect(response).to redirect_to(myproject_path)
      end

      it 'invites a user to a project' do
        project = create(:project, user: user)
        john = create(:user, name: 'john')
        alex = create(:user, name: 'alex')
        johnny = create(:user, name: 'johnny')
        get :invite, params: { id: project.id }
        expect(assigns(:users)).to eq [john, alex, johnny]
        get :invite, xhr: true, params: { id: project.id, search: 'jo' }
        expect(assigns(:users)).to eq [john, johnny]
      end

      it 'shows logs' do
        project = create(:project, user: user)
        column = create(:column, project: project)
        create(:card, column: column)
        get :logs, params: { id: project.id }
        expect(assigns(:logs).count).to eq 2
      end
    end
  end
end
