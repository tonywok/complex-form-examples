class ProjectsController < ApplicationController
  def index
    @projects = Project.find(:all)
  end
  
  def show
    @project = Project.find(params[:id])
  end
  
  def new
    @project = Project.new
  end
 
  def create
    @project = Project.new(params[:project])
    if params[:add_task] || !@project.save 
      3.times { @project.tasks.build }
      render :action => 'new'
    else
      redirect_to @project
    end
  end

  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated project."
      redirect_to @project
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    redirect_to projects_url
  end
end
