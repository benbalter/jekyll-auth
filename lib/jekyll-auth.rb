require 'rubygems'
require 'sinatra-index'
require 'sinatra_auth_github'
require 'rack'

class JekyllAuth

  VERSION = '0.1.0'

  class AuthSite < Sinatra::Base

    use Rack::Session::Cookie, :secret => ENV['SESSION_SECRET'] || SecureRandom.hex

    set :github_options, {
      :client_id     => ENV['GITHUB_CLIENT_ID'],
      :client_secret => ENV['GITHUB_CLIENT_SECRET'],
      :scopes        => 'user'
    }

    register Sinatra::Auth::Github

    before do
      if ENV['GITHUB_TEAM_ID']
        github_team_authenticate!(ENV['GITHUB_TEAM_ID'])
      elsif ENV['GITHUB_ORG_ID']
        github_organization_authenticate!(ENV['GITHUB_ORG_ID'])
      else
        puts "ERROR: Jekyll Auth is refusing to serve your site."
        puts "Looks like your oauth credentials are not properly configured. RTFM."
        halt 401
      end
    end
  end

  class JekyllSite < Sinatra::Base
    register Sinatra::Index
    set :public_folder, '_site'
    use_static_index 'index.html'
  end

  def self.site
    Rack::Builder.new do
      use JekyllAuth::AuthSite
      run JekyllAuth::JekyllSite
    end
  end
end
