require 'rubygems'
require 'sinatra-index'
require 'sinatra_auth_github'
require 'rack'
require 'dotenv'
require 'safe_yaml'
require_relative 'jekyll-auth/version'
require_relative 'jekyll-auth/config'
require_relative 'jekyll-auth/auth-site'
require_relative 'jekyll-auth/jekyll-site'
Dotenv.load

class JekyllAuth
  def self.site
    Rack::Builder.new do
      use JekyllAuth::AuthSite
      run JekyllAuth::JekyllSite
    end
  end
end
