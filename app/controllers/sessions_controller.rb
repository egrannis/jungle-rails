class SessionsController < ApplicationController
  def new
  end

  def create
    # If the user exists AND the password entered is correct.
    # user = User.find_by_email(params[:email])

    @user = User.authenticate_with_credentials(params[:email], params[:password]) #request body

    # Save the user id inside the browser cookie. 
    # logged in when they navigate around our website.
    if @user
      session[:user_id] = @user.id
      redirect_to '/'
    else
      # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end

