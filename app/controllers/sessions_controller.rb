# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user &. authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Looks like your email or password is invalid'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def github_login
    token = request.env['omniauth.auth']['credentials']['token']
    gh_id = request.env['omniauth.auth']['extra']['raw_info']['id']
    current_user.update_attributes(token: token, gh_id: gh_id)
    redirect_to dashboard_path
  end
end
