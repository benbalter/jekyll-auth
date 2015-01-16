# Jekyll Auth

*A simple way to use GitHub OAuth to serve a protected jekyll site to your GitHub organization*

[![Gem Version](https://badge.fury.io/rb/jekyll-auth.png)](http://badge.fury.io/rb/jekyll-auth) [![Build Status](https://travis-ci.org/benbalter/jekyll-auth.png?branch=master)](https://travis-ci.org/benbalter/jekyll-auth)

## The problem

[Jekyll](http://github.com/mojombo/jekyll) and [GitHub Pages](http://pages.github.com) are awesome, right? Static site, lightning fast, everything versioned in Git. What else could you ask for?

But what if you only want to share that site with a select number of people? Before, you were SOL. Now, simply host the site on a free, [Heroku](http://heroku.com) Dyno, and whenever someone tries to access it, it will oauth them against GitHub, and make sure they're a member of your Organization. Pretty cool, huh?

## Requirements

1. A GitHub account (one per user)
2. A GitHub Organization (of which members will have access to the Jekyll site)
3. A GitHub Application (You can always [register one](https://github.com/settings/applications/new) for free)
4. A heroku account

## Getting Started

### Create a GitHub Application

1. Navigate to [the GitHub app registration page](https://github.com/settings/applications/new)
2. Give your app a name
3. Tell GitHub the URL you want the app to eventually live at
4. The Callback Url is your apps's URL + `/auth/github/callback`
5. Hit Save, but leave the page open, you'll need some of the information in a moment

### Add Jekyll Auth to your site

First, add `gem 'jekyll-auth'` to your `Gemfile` or if you don't already have a `Gemfile`, create a file called `Gemfile` in the root of your site's repository with the following content:

```
source "https://rubygems.org"

gem 'jekyll-auth'
```

Next, `cd` into your project's directory and run `bundle install`.

Finally, run `jekyll-auth new` which will run you through everything you need to set up your site with Jekyll Auth.

### Whitelisting

Don't want to require authentication for every part of your site? Fine! Add a whitelist to your Jekyll's *_config.yml_* file:

```yaml
jekyll_auth:
  whitelist:
    - drafts?
```

`jekyll_auth.whitelist` takes an array of regular expressions as strings. The default auth behavior checks (and blocks) against root (`/`). Any path defined in the whitelist won't require authentication on your site.

What if you want to go the other way, and unauthenticate the entire site _except_ for certain portions? You can define some regex magic for that:

```yaml
jekyll_auth:
  whitelist:
    - "^((?!draft).)*$"
```

## Requiring SSL

If [you've got SSL set up](https://devcenter.heroku.com/articles/ssl-endpoint), simply add the following your your `_config.yml` file to ensure SSL is enforced.

```yaml
jekyll_auth:
  ssl: true
```

## Running locally

Want to run it locally?

### Without authentication

Just run `jekyll serve` as you would normally

### With authentication

1. `export GITHUB_CLIENT_ID=[your github app client id]`
2. `export GITHUB_CLIENT_SECRET=[your github app client secret]`
3. `export GITHUB_ORG_ID=[org id]` or `export GITHUB_TEAM_ID=[team id]` or `export GITHUB_TEAM_IDS=1234,5678`
4. `jekyll-auth serve`

*Pro-tip #1:* For sanity sake, and to avoid problems with your callback URL, you may want to have two apps, one with a local oauth callback, and one for production if you're going to be testing auth locally.

*Pro-tip #2*: Jekyll Auth supports [dotenv](https://github.com/bkeepers/dotenv) out of the box. You can create a `.env` file in the root of site and add your configuration variables there. It's ignored by `.gitignore` if you use `jekyll-auth new`, but be sure not to accidentally commit your `.env` file. Here's what your `.env` file might look like:

```
GITHUB_CLIENT_SECRET=abcdefghijklmnopqrstuvwxyz0123456789
GITHUB_CLIENT_ID=qwertyuiop0001
GITHUB_TEAM_ID=12345
```

*Pro-tip #3*: If you need help finding a team's numeric ID, you can use the `jekyll-auth team_id` command. For example, to find the team ID for @jekyll/maintainers you'd run the command `jekyll-auth team_id --org jekyll --team maintainers`. You'll want to add a [personal access token](https://github.com/settings/tokens/new) to your `.env` file so that Jekyll-Auth can make the necessary API request, but the command will run you through the process if you dont.

## Under the hood

Every time you push to Heroku, we take advantage of the fact that Heroku automatically runs the `rake assets:precompile` command (normally used for Rails sites) to build our Jekyll site and store it statically, just like GitHub pages would.

Anytime a request comes in for a page, we run it through [Sinatra](http://www.sinatrarb.com/) (using the `_site` folder as the static file folder, just as `public` would be normally), and authenticate it using [sinatra_auth_github](https://github.com/atmos/sinatra_auth_github).

If they're in the org, they get the page. Otherwise, all they ever get is [the bouncer](http://octodex.github.com/bouncer/).

## Upgrading from Jekyll Auth < 0.1.0

1. `cd` to your project directory
2. `rm config.ru`
3. `rm Procfile`
4. Remove any Jekyll Auth specific requirements from your `Gemfile`
5. Follow [the instructions above](https://github.com/benbalter/jekyll-auth#add-jekyll-auth-to-your-site) to get started
6. When prompted, select "n" if Heroku is already set up
