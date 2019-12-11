require 'rails_helper'

RSpec.describe 'User', :vcr do
   it 'can send invite with github handle and email associated' do
      @user = create(:user, token: ENV['USER_GITHUB_TOKEN'], gh_id: 47759923)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      visit dashboard_path

      click_button "Send an Invite"

      expect(current_path).to eq(invite_path)

      fill_in "invitation[github_handle]", with: "hillstew1234"
      click_button "Send Invite"

      expect(current_path).to eq(dashboard_path)

      message = "Successfully sent invite!"
      expect(page).to have_content(message)
   end
end