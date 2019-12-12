require 'rails_helper'

RSpec.describe YouTube::Video do
  it "is initialized with a thumbnail" do
    data = { items: { snippet: { thumbnails: { high: {url: 'test_url'}}}}}
    YouTube::Video.new(data)
  end
end
