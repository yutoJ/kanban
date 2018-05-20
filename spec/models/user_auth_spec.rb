require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'create user through sns auth' do
    Info = Struct.new(:nickname, :image).new('mike', '')
    Name = Struct.new(:name).new('mike')
    Image = Struct.new(:image).new('')
    RawInfo = Struct.new(:raw_info).new(Name)
    FacebookAuth = Struct.new(:extra, :uid, :provider, :info).new(RawInfo, '1234', 'facebook', Image)
    TwitterAuth = Struct.new(:info, :uid, :provider).new(Info, '1234', 'twitter')
    GithubAuth = Struct.new(:info, :uid, :provider).new(Info, '1234', 'github')
    it 'case of facebook user' do
      actual = User.create_fb_auth(FacebookAuth)

      expect(actual.name).to eq 'mike'
      expect(actual.uid).to eq '1234'
      expect(actual.provider).to eq 'facebook'
    end

    it 'case of twitter user' do
      actual = User.create_tw_auth(TwitterAuth)

      expect(actual.name).to eq 'mike'
      expect(actual.uid).to eq '1234'
      expect(actual.provider).to eq 'twitter'
    end

    it 'case of github user' do
      actual = User.create_gh_auth(GithubAuth)

      expect(actual.name).to eq 'mike'
      expect(actual.uid).to eq '1234'
      expect(actual.provider).to eq 'github'
    end

    it 'find sns auth user' do
      actual = User.create_gh_auth(GithubAuth)
      expected = User.find_for_auth(GithubAuth)

      expect(actual).to eq expected
    end
  end
end
