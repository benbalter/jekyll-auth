class JekyllAuth
  class AuthSite < Sinatra::Base

    use Rack::Session::Cookie, :secret => ENV['SESSION_SECRET'] || SecureRandom.hex

    set :github_options, {
      :client_id     => ENV['GITHUB_CLIENT_ID'],
      :client_secret => ENV['GITHUB_CLIENT_SECRET'],
      :scopes        => 'user'
    }

    register Sinatra::Auth::Github

    before do
      pass if JekyllAuth.whitelist && JekyllAuth.whitelist.match(request.path_info)
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
end
