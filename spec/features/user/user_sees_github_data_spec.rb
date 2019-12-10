require 'rails_helper'

describe 'User' do
  describe "When I visit my dashboard", :vcr do
    before(:each) do
      @user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
    end

    it "I see a Connect to Github button if not connected" do
      expect(page).to have_button("Connect to Github")
    end

    it 'can connect with Github OAuth and see 5 repos' do
      click_button "Connect to Github"

      expect(page.status_code).to eq(200)
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Repositories')
      within("#repositories") do
        expect(page).to have_link(count: 5)
      end
    end

    it "can see all github followers" do
      click_button "Connect to Github"

      expect(page).to have_content('Followers')
      within("#followers") do
        expect(page).to have_css('.github-follower')
      end
    end

    it "can see all github users that the current user is following" do
      click_button "Connect to Github"

      expect(page).to have_content('Following')
      within("#following") do
        expect(page).to have_css('.github-following')
      end
    end

    it "sees notifications for lack of github content" do
      @user_2 = create(:user, token: ENV['EMPTY_USER_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_2)
      visit dashboard_path

      expect(page).to have_content('Repositories')
      expect(page).to have_content('Followers')
      expect(page).to have_content('Following')
      within('#repositories') do
        expect(page).to have_content("You don't have any Github repositories")
      end
      within('#followers') do
        expect(page).to have_content("You don't have any Github followers")
      end
      within('#following') do
        expect(page).to have_content("You aren't following anyone on Github")
      end
    end

    it "should be able to add friends who are in the database" do
      @user_2 = create(:user, token: ENV['USER_GITHUB_TOKEN_2'], gh_id: 36748280)
      
      click_button "Connect to Github"

      within "#follower-links-#{@user_2.gh_id}" do
        click_link "Add Friend"
      end
      
      expect(current_path).to eq(dashboard_path)

      within "#follower-links-#{@user_2.gh_id}" do
        expect(page).to_not have_link("Add Friend")
      end

      within "#friends" do
        expect(page).to have_content(@user_2.full_name)
      end
    end

    it "should see a flash message if friend id doesnt exists" do
      visit '/add_friend/49857389'

      expect(page).to have_content("Yikes, could not find that friend")
    end
  end
end
