require 'rails_helper'

RSpec.describe GithubUser do
  it "is initialized with attributes from a hash" do
    user_data = { login: 'rhantak', html_url: 'github.com/rhantak', id: 123 }

    gh_user = GithubUser.new(user_data)

    expect(gh_user.name).to eq('rhantak')
    expect(gh_user.url).to eq('github.com/rhantak')
    expect(gh_user.gh_id).to eq(123)
  end

  it "can tell if the github user is in the users table" do
    user_data = { login: 'rhantak', html_url: 'github.com/rhantak', id: 123 }
    gh_user = GithubUser.new(user_data)

    expect(gh_user.account?).to eq(false)

    create(:user, gh_id: gh_user.gh_id)

    expect(gh_user.account?).to eq(true)
  end
end
