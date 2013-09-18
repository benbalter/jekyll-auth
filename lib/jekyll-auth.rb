require 'rubygems'
require 'sinatra-index'
require 'sinatra_auth_github'
require 'rack'
require 'jekyll-auth/version'
require 'jekyll-auth/auth-site'
require 'jekyll-auth/jekyll-site'

class JekyllAuth
  def self.site
    Rack::Builder.new do
      use JekyllAuth::AuthSite
      run JekyllAuth::JekyllSite
    end
  end
end
