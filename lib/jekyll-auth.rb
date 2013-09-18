require 'rubygems'
require 'sinatra-index'
require 'sinatra_auth_github'
require 'rack'
require File.dirname(__FILE__) + '/jekyll-auth/version'
require File.dirname(__FILE__) + '/jekyll-auth/auth-site'
require File.dirname(__FILE__) + '/jekyll-auth/jekyll-site'

class JekyllAuth
  def self.site
    Rack::Builder.new do
      use JekyllAuth::AuthSite
      run JekyllAuth::JekyllSite
    end
  end
end
