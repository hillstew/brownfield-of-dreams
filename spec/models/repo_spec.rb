require 'rails_helper'

RSpec.describe Repo do
  it "is initialized with attributes from a hash" do  
    repo_info = {name: 'flashcards', html_url: 'github.com/rhantak/flashcards'}
    repo = Repo.new(repo_info)

    expect(repo.name).to eq('flashcards')
    expect(repo.url).to eq('github.com/rhantak/flashcards')
  end
end
