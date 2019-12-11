require 'rails_helper'

describe InvitationMailer do
  describe 'invite message' do
    let(:user) { create(:user) }
    invitee = {email: "hillstew1234@gmail.com", name: "Hillary"}
    let(:mail) { InvitationMailer.invite(invitee, user) }

    it "send user email to activate account" do
      mail.subject.should eq("Brownfield Tutorial Invite")
      mail.to.should eq([invitee[:email]])
      mail.from.should eq(["no-reply@brownfield.com"])
      mail.body.encoded.should match(register_url)
    end
  end
end