# app/controllers/invitation_controller.rb
class InvitationController < ApplicationController
  def new; end

  def create
    gh_handle = params['invitation']['github_handle']
    invitee_info = GithubService.new(current_user.token)
                                .fetch_invitee_info(gh_handle)
    if invitee_info[:email]
      send_invitation(invitee_info)
      flash[:success] = 'Successfully sent invite!'
    else
      flash[:error] = no_email_message
    end
    redirect_to dashboard_path
  end

  private

  def send_invitation(invitee_info)
    InvitationMailer.invite({ email: invitee_info[:email],
                              name: invitee_info[:name] }, current_user)
                    .deliver_now
  end

  def no_email_message
    'The Github user you selected does not have an
    email address associated with their account.'
  end
end
