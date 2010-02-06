class ArticlesController < ApplicationController
  def index
    @articles = Articles.find(:all)
  end
  
  def show
    @articles = Articles.find(params[:id])
  end
  
  def new
    @articles = Articles.new
  end
  
  def create
    @articles = Articles.new(params[:articles])
    if @articles.save
      flash[:notice] = "Successfully created articles."
      redirect_to @articles
    else
      render :action => 'new'
    end
  end
  
  def edit
    @articles = Articles.find(params[:id])
  end
  
  def update
    @articles = Articles.find(params[:id])
    if @articles.update_attributes(params[:articles])
      flash[:notice] = "Successfully updated articles."
      redirect_to @articles
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @articles = Articles.find(params[:id])
    @articles.destroy
    flash[:notice] = "Successfully destroyed articles."
    redirect_to articles_url
  end
end
