# app/serializers/video_serializer.rb
class VideoSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :position
end
