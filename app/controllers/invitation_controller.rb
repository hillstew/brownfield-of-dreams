class InvitationController < ApplicationController
  def new
  end

  def create
    gh_handle = params["invitation"]["github_handle"]
    invitee_info = GithubService.new(current_user.token).fetch_invitee_info(gh_handle)
    if invitee_info[:email]
      InvitationMailer.invite({email: invitee_info[:email], name: invitee_info[:name]}, current_user).deliver_now
      flash[:success] = "Successfully sent invite!"
    else 
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end
end