class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.find_by(email: user.email) #if the user's email already exists in the DB
      redirect_do '/signup' #return them to the signup page
    else 
    if user.save
      session[:user_id] = user.id
      redirect_to '/'
      # redirect_to [:root] 
    else
      redirect_to '/signup'  #same as writing new_user_path, refer to bin/rails routes
      # redirect_to [:new, :user]  #same as writing new_user_path, refer to bin/rails routes
    end    
  end   

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end