require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'instance methods' do
    before(:each) do
      @user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', last_name:'Smith', role: 0)
    end

    it "can print its full name" do
      expect(@user.full_name).to eq('Jim Smith')
    end

    it "can tell if it is friends with another user" do
      gh_user_data = { login: 'rhantak', html_url: 'github.com/rhantak', id: 123 }
      gh_user = GithubUser.new(gh_user_data)
      user_2 = create(:user, gh_id: gh_user.gh_id)

      expect(@user.friends_with?(gh_user)).to eq(false)

      Friendship.create(user_id: @user.id, friend_id: user_2.id)

      expect(@user.friends_with?(gh_user)).to eq(true)
    end

    it "can make a hash of its bookmarks grouped by tutourial id" do
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

      expected = { tutorial_1.id => [video_3, video_4, video_1],
                    tutorial_2.id => [video_2] }
      expect(@user.bookmarks).to eq(expected)
    end
  end
end
