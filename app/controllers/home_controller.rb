class HomeController < BaseController
  before_action :login_required, only: [:search]

  def search
    max_id = params['max_id'].present? ? params['max_id'] : nil
    word = @word = params['word']
    
    begin
      results = twitter_client.search(word, {max_id: max_id, count: 100}).statuses
      @max_id = results.last.id
      
      if @current_user.follower_ids.nil?
        @current_user.follower_ids = twitter_client.follower_ids.to_a.join(' ')
        @current_user.save!
      end 
      follower_ids =  @current_user.follower_ids.split(' ').map {|id| id.to_i}
      @tweets = results.select {|tweet| follower_ids.include?(tweet.user.id)}
    rescue Twitter::Error => e
      @error = "API制限です" if e.message.match(/Rate limit exceeded/)
    end
  end

  def twitter_client
    Twitter::Client.new(
      :oauth_token        => @current_user.token,
      :oauth_token_secret => @current_user.secret
    )
  end

end
