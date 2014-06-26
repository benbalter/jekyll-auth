require './lib/jekyll-auth/version'

Gem::Specification.new do |s|

  s.name                  = "jekyll-auth"
  s.version               = JekyllAuth::VERSION
  s.summary               = "A simple way to use Github OAuth to serve a protected jekyll site to your GitHub organization"
  s.description           = "A simple way to use Github Oauth to serve a protected jekyll site to your GitHub organization."
  s.authors               = "Ben Balter"
  s.email                 = "ben@balter.com"
  s.homepage              = "https://github.com/benbalter/jekyll-auth"
  s.license               = "MIT"
  s.files                 = ["lib/jekyll-auth.rb", "bin/jekyll-auth", "config.ru", "Rakefile",
                             "lib/jekyll-auth/auth-site.rb", "lib/jekyll-auth/jekyll-site.rb",
                             "lib/jekyll-auth/version.rb", "lib/jekyll-auth/config.rb", ".gitignore"]
  s.executables           = ["jekyll-auth"]

  s.add_dependency("jekyll", "~> 2.0")
  s.add_dependency("sinatra-index", "~> 0.0")
  s.add_dependency("sinatra_auth_github", "~> 1.0")
  s.add_dependency("commander", "~> 4.1")
  s.add_dependency("heroku", "~> 3.6")
  s.add_dependency("git", "~> 1.2")
  s.add_dependency("dotenv", "~> 0.11")
  s.add_dependency("rake", "~> 10.3")
  s.add_dependency("rack-ssl-enforcer", "~> 0.2")
  s.add_runtime_dependency('safe_yaml', "~> 1.0")
end
