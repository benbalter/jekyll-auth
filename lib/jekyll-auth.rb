require 'sinatra-index'
require 'sinatra_auth_github'
require 'dotenv'
require 'safe_yaml'
require 'colorator'
require 'mkmf'
require_relative 'jekyll_auth/version'
require_relative 'jekyll_auth/helpers'
require_relative 'jekyll_auth/config'
require_relative 'jekyll_auth/auth_site'
require_relative 'jekyll_auth/jekyll_site'
require_relative 'jekyll_auth/config_error'
require_relative 'jekyll_auth/commands'

Dotenv.load

class JekyllAuth
  def self.site
    Rack::Builder.new do
      use JekyllAuth::AuthSite
      run JekyllAuth::JekyllSite
    end
  end
end
