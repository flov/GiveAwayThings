class SectionsController < ApplicationController
  def index
    @sections = Sections.find(:all)
  end
  
  def show
    @sections = Sections.find(params[:id])
  end
  
  def new
    @sections = Sections.new
  end
  
  def create
    @sections = Sections.new(params[:sections])
    if @sections.save
      flash[:notice] = "Successfully created sections."
      redirect_to @sections
    else
      render :action => 'new'
    end
  end
  
  def edit
    @sections = Sections.find(params[:id])
  end
  
  def update
    @sections = Sections.find(params[:id])
    if @sections.update_attributes(params[:sections])
      flash[:notice] = "Successfully updated sections."
      redirect_to @sections
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @sections = Sections.find(params[:id])
    @sections.destroy
    flash[:notice] = "Successfully destroyed sections."
    redirect_to sections_url
  end
end
