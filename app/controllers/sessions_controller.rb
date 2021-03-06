class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_url
    else
      render 'new', notice: 'Bad username/password'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
