require 'rails_helper'

describe 'User' do
  it "can all bookmarked videos on my dashboard" do
    @user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    tutorial_1 = create(:tutorial)
    tutorial_2 = create(:tutorial)
    video_1 = create(:video, tutorial_id: tutorial_1.id, position: 3)
    video_2 = create(:video, tutorial_id: tutorial_2.id, position: 1)
    video_3 = create(:video, tutorial_id: tutorial_1.id, position: 1)
    video_4 = create(:video, tutorial_id: tutorial_1.id, position: 2)

    @user.user_videos.create(video_id: video_1.id)
    @user.user_videos.create(video_id: video_2.id)
    @user.user_videos.create(video_id: video_3.id)
    @user.user_videos.create(video_id: video_4.id)

    visit dashboard_path

    expect(page).to have_css(".bookmarks")
    within(".bookmarks") do
      expect(page).to have_content("Bookmarked Segments")

      expect(page).to have_content(tutorial_1.title)
      expect(page).to have_content(tutorial_2.title)

      expect(page).to have_content(video_3.title)
      expect(page).to have_content(video_4.title)
      expect(page).to have_content(video_1.title)
      expect(page).to have_content(video_2.title)
    end
  end
end
