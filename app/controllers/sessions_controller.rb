class SessionsController < ApplicationController
  def new
  end
  
  def create
    person = Person.authenticate(params[:login], params[:password])
    if person
      unless person.is_active?
        flash[:error] = "You need to confirm your email, please check your mails."
        redirect_to unconfirmed_email_person_path(person.username) 
      else
        session[:person_id] = person.id
        flash[:notice] = "Logged in successfully."
        redirect_to_target_or_default(root_url)
      end
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end
  
  def destroy

    session[:person_id] = nil
    redirect_to root_url
  end
end
