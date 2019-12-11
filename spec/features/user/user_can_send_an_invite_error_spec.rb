require 'rails_helper'

RSpec.describe "User", :vcr do
  it 'will not send an invite because no email associated' do
     @user = create(:user, token: ENV['USER_GITHUB_TOKEN_2'], gh_id: 36748280)
     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

     visit dashboard_path

     click_button "Send an Invite"

     expect(current_path).to eq(invite_path)

     fill_in "invitation[github_handle]", with: "rhantak"
     click_button "Send Invite"

     expect(current_path).to eq(dashboard_path)

     message = "The Github user you selected doesn't have an email address associated with their account."
     expect(page).to have_content(message)
  end
end