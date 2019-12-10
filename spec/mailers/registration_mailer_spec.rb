require 'rails_helper'

describe RegistrationMailer do
  describe 'account activation' do
    let(:user) { create(:user) }
    let(:mail) { RegistrationMailer.activate(user) }

    it "send user email to activate account" do
      mail.subject.should eq("Visit here to activate your account")
      mail.to.should eq([user.email])
      mail.from.should eq(["no-reply@brownfield.com"])
      mail.body.encoded.should match(activation_url)
    end
  end
end