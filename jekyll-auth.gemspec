Gem::Specification.new do |s|

  s.name                  = "jekyll-auth"
  s.version               = "0.1.0"
  s.summary               = "A simple way to use Github OAuth to serve a protected jekyll site to your GitHub organization"
  s.description           = "A simple way to use Github Oauth to serve a protected jekyll site to your GitHub organization."
  s.authors               = "Ben Balter"
  s.email                 = "ben@balter.com"
  s.homepage              = "https://github.com/benbalter/jekyll-auth"
  s.license               = "MIT"
  s.files                 = ["lib/jekyll-auth.rb", "bin/jekyll-auth", "config.ru", "Rakefile"]
  s.executables           = ["jekyll-auth"]

  s.add_dependency("github-pages")
  s.add_dependency("octokit", '~>1.25.0')
  s.add_dependency("sinatra-index")
  s.add_dependency("sinatra_auth_github")
  s.add_dependency("commander")
  s.add_dependency("heroku")
  s.add_development_dependency("rake")
end
