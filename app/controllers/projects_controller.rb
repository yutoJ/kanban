class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  def index
    paginates_per = request.xhr? ? 9 : 8
    @projects = Project.page(params[:page]).per(paginates_per)
    respond_to do |format|
      format.html
      format.js
    end
  end
end
