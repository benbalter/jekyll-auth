class JekyllAuth
  class AuthSite < Sinatra::Base

    configure :production do
      require 'rack-ssl-enforcer'
      use Rack::SslEnforcer if JekyllAuth.ssl?
    end

    use Rack::Session::Cookie, {
      :http_only => true,
      :secret    => ENV['SESSION_SECRET'] || SecureRandom.hex
    }

    set :github_options, {
      :scopes    => 'read:org'
    }

    ENV['WARDEN_GITHUB_VERIFIER_SECRET'] ||= SecureRandom.hex
    register Sinatra::Auth::Github

    def whitelisted?
      JekyllAuth.whitelist && JekyllAuth.whitelist.match(request.path_info)
    end

    def authentication_strategy
      if ENV['GITHUB_TEAM_ID']
        :team
      elsif ENV['GITHUB_TEAMS_ID']
        :teams
      elsif ENV['GITHUB_ORG_ID']
        :org
      end
    end

    before do
      pass if whitelisted?

      case authentication_strategy
      when :team
        github_team_authenticate! ENV['GITHUB_TEAM_ID']
      when :teams
        github_teams_authenticate! ENV['GITHUB_TEAM_IDS'].split(",")
      when :org
        github_organization_authenticate! ENV['GITHUB_ORG_ID']
      else
        puts "ERROR: Jekyll Auth is refusing to serve your site."
        puts "Looks like your oauth credentials are not properly configured. RTFM."
        halt 401
      end
    end

    get '/logout' do
      logout!
      redirect '/'
    end
  end
end
