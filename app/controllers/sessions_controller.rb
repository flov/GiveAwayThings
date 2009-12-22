class SessionsController < ApplicationController
  def new
  end
  
  def create
    person = Person.authenticate(params[:login], params[:password])
    if person
      session[:person_id] = person.id
      flash[:notice] = "Logged in successfully."
      redirect_to_target_or_default(root_url)
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end
  
  def destroy
    session[:person_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_url
  end
end
