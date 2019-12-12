# app/models/user.rb
class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :friendships
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def friends_with?(gh_user)
    friend = User.find_by(gh_id: gh_user.gh_id)
    friends = friendships.where(friend_id: friend.id)
    if friends.empty?
      false
    else
      true
    end
  end

  def raw_bookmarks
    videos.joins(:tutorial)
          .select('videos.*')
          .group('tutorials.id, videos.id')
          .order(:tutorial_id, :position)
  end

  def bookmarks
    finished_bookmarks = {}
    raw_bookmarks.each do |bookmark|
      finished_bookmarks[bookmark.tutorial_id] ||= []
      finished_bookmarks[bookmark.tutorial_id] << bookmark
    end
    finished_bookmarks
  end
end
