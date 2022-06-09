class UsersController < ApplicationController
  
  def new #new is a GET
    @user = User.new
  end

  def create #create is a POST
    user = User.new(user_params) #want to keep DB clean, so separate out new and save. Also can account for other preferences
  
    if user.save #method to save user.new is successful - true 
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
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation) # permitting the params that the fields can even accept. is a security purpose preventing abuse of post request
  end
end