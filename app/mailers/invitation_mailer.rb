class InvitationMailer < ApplicationMailer
  def invite(invitee, current_user)
    @invitee = invitee
    @current_user = current_user
    mail(to: @invitee[:email], subject: "Brownfield Tutorial Invite")
  end
end