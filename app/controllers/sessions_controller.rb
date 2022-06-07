class SessionsController < ApplicationController
  def new
  end

  def create
    # If the user exists AND the password entered is correct.
    if user = User.authenticate_with_credentials(params[:email].strip, params[:password]) # strip returns a copy of a string with leading and trailing whitespace removed
      # Save the user id inside the browser cookie. This is how we keep the user logged in when they navigate around the website.
      session[:user_id] = user.id
      redirect_to '/'
    else
      # If the login doesn't work (not authenticated w creds), send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end