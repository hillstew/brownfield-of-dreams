# app/models/github_user.rb
class GithubUser
  attr_reader :name, :url, :gh_id

  def initialize(user_data)
    @name = user_data[:login]
    @url = user_data[:html_url]
    @gh_id = user_data[:id]
  end

  def account?
    if User.find_by(gh_id: gh_id)
      true
    else
      false
    end
  end
end
