module OmniauthUtils
  def set_twitter_mock_auth
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: '1234',
      info: {
        nickname: 'yutoJ',
        image: ''
      }
    )
  end
end
