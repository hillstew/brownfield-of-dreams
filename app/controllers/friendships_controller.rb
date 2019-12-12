# app/controllers/friendships_controller.rb
class FriendshipsController < ApplicationController
  def create
    friend = User.find_by(gh_id: params[:follower_id].to_i)
    if friend
      @friendship = current_user.friendships.create(friend_id: friend.id)
    else
      flash[:error] = 'Yikes, could not find that friend'
    end
    redirect_to dashboard_path
  end
end
