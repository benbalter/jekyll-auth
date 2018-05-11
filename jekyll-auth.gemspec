# frozen_string_literal: true

require "./lib/jekyll_auth/version"

Gem::Specification.new do |s|
  s.name                  = "jekyll-auth"
  s.version               = JekyllAuth::VERSION
  s.summary               = "A simple way to use GitHub OAuth to serve a protected jekyll site to your GitHub organization"
  s.description           = "A simple way to use GitHub OAuth to serve a protected jekyll site to your GitHub organization."
  s.authors               = "Ben Balter"
  s.email                 = "ben@balter.com"
  s.homepage              = "https://github.com/benbalter/jekyll-auth"
  s.license               = "MIT"
  s.files                 = `git ls-files`.split("\n")
  s.test_files            = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables           = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths         = ["lib"]

  s.add_dependency "activesupport", "~> 4.0"
  s.add_dependency "colorator", "~> 1.0"
  s.add_dependency "dotenv", "~> 2.0"
  s.add_dependency "jekyll", "~> 3.0"
  s.add_dependency "mercenary", "~> 0.3"
  s.add_dependency "rack", "~> 2.0"
  s.add_dependency "rack-protection", "~> 2.0"
  s.add_dependency "rack-ssl-enforcer", "~> 0.2"
  s.add_dependency "rake", "~> 12.0"
  s.add_dependency "safe_yaml", "~> 1.0"
  s.add_dependency "sinatra", "~> 2.0"
  s.add_dependency "sinatra-index", "~> 0.0"
  s.add_dependency "sinatra_auth_github", "~> 2.0"
  s.add_development_dependency "pry", "~> 0.11"
  s.add_development_dependency "rack-test", "~> 0.8"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency "rubocop", "~> 0.49", ">= 0.49.0"
  s.add_development_dependency "webmock", "~> 3.0"
end
