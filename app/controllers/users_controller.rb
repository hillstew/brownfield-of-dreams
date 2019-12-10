class UsersController < ApplicationController
  def show
    if current_user
      render locals: {
        user: UserDecorator.new(current_user)
      }
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      RegistrationMailer.activate(user).deliver_now
      flash[:success] = "Logged in as #{user.first_name}."
      flash[:notice] = "This account has not yet been activated. Please check your email."
      redirect_to dashboard_path
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

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
