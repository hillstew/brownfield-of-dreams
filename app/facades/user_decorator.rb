# app/facades/user_decorator.rb
class UserDecorator < SimpleDelegator
  def initialize(user)
    @user = super(user)
  end

  def repos
    raw_repo_data = repo_data
    create_repos(raw_repo_data)
  end

  def followers
    raw_follower_data = follower_data
    create_gh_users(raw_follower_data)
  end

  def following
    raw_following_data = following_data
    create_gh_users(raw_following_data)
  end

  private

  attr_reader :user

  def repo_data
    @repo_data ||= service.fetch_repos
  end

  def follower_data
    @follower_data ||= service.fetch_followers
  end

  def following_data
    @following_data ||= service.fetch_following
  end

  def service
    GithubService.new(user.token)
  end

  def create_repos(raw_repo_data)
    raw_repo_data.map do |repo|
      Repo.new(repo)
    end[0..4]
  end

  def create_gh_users(raw_user_data)
    raw_user_data.map do |user|
      GithubUser.new(user)
    end
  end
end
