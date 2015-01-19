require "spec_helper"

describe "jekyll site" do
  include Rack::Test::Methods

  def app
    JekyllAuth::JekyllSite
  end

  before do
    setup_tmp_dir
    File.write File.expand_path("_config.yml", tmp_dir), "foo: bar"
    `bundle exec jekyll build`
  end

  it "serves the index" do
    get "/"
    expect(last_response.body).to eql("My awesome site")
  end

  it "serves a page" do
    get "/index.html"
    expect(last_response.body).to eql("My awesome site")
  end

  it "serves a directory index" do
    get "/some_dir"
    expect(last_response.body).to eql("My awesome directory")
  end

end
