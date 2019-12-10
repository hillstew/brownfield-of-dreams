class GithubUser
  attr_reader :name, :url, :gh_id

  def initialize(user_data)
    @name = user_data[:login]
    @url = user_data[:html_url]
    @gh_id = user_data[:id]
  end

  def has_account?
    User.find_by(gh_id: self.gh_id)
  end
end
