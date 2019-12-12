# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def show
    return unless current_user

    render locals: {
      user: UserDecorator.new(current_user)
    }
  end

  def new
    @user = User.new
  end

  def create
    if (user = User.create(user_params))
      creation_success(user)
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def update
    current_user.update_attribute(status: 'active')
    redirect_to confirmation_path
  end

  private

  def creation_success(user)
    session[:user_id] = user.id
    RegistrationMailer.activate(user).deliver_now
    flash[:success] = "Logged in as #{user.first_name}."
    flash[:notice] =
      'This account has not yet been activated. Please check your email.'
    redirect_to dashboard_path
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
