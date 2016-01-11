class HomeController < BaseController
  before_action :login_required, only: [:tweet, :search]

  def index
  end

  # 定型文をつぶやく
  def tweet
    text = "テストツイートです"
    twitter_client.update(text)
    flash[:notice] = "tweet: #{text}"
    redirect_to root_path
  end

  def search
    @tweets = twitter_client.home_timeline
  end

  private
  def twitter_client
    binding.pry
    Twitter::Client.new(
      :oauth_token        => @current_user.token,
      :oauth_token_secret => @current_user.secret
    )
  end

end
