# app/models/repo.rb
class Repo
  attr_reader :name, :url

  def initialize(repo_info)
    @name = repo_info[:name]
    @url = repo_info[:html_url]
  end
end
