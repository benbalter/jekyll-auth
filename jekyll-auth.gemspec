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
                             "lib/jekyll-auth/version.rb"]
  s.executables           = ["jekyll-auth"]

  s.add_dependency("github-pages")
  s.add_dependency("sinatra-index")
  s.add_dependency("sinatra_auth_github")
  s.add_dependency("commander")
  s.add_dependency("heroku")
  s.add_dependency("git")
  s.add_development_dependency("rake")
end
