# app/models/user_video.rb
class UserVideo < ApplicationRecord
  belongs_to :video, foreign_key: 'video_id'
  belongs_to :user, foreign_key: 'user_id'
end
