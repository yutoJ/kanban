class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: %i[index myproject]
  def index
    paginates_per = request.xhr? ? 9 : 8
    @projects = Project.page(params[:page]).per(paginates_per)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def myproject
    paginates_per = request.xhr? ? 9 : 8
    @projects = current_user.projects.page(params[:page]).per(paginates_per)
    respond_to do |format|
      format.html
      format.js
    end
  end
end
