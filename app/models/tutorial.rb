# app/models/tutorial.rb
class Tutorial < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :thumbnail
  has_many :videos, ->  { order(position: :ASC) }, dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos
end
