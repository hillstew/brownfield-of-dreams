require 'rails_helper'

RSpec.describe 'As a user' do
  it "I can activate my account by clicking a link in my activation email" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    mail = RegistrationMailer.activate(user)

    if mail.body.encoded match(activation_url)
      visit activation_path
    end

    expect(User.find(user.id).status).to eq('active')
  end
end
