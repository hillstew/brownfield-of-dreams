# app/models/video.rb
class Video < ApplicationRecord
  validates_presence_of :position
  has_many :user_videos
  has_many :users, through: :user_videos, dependent: :destroy
  belongs_to :tutorial
end
