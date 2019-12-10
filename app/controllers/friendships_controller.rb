class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(gh_id: params[:follower_id].to_i)
    @friendship = current_user.friendships.create(:friend_id => friend.id)
    redirect_to dashboard_path
  end
end