class JekyllAuth
  class JekyllSite < Sinatra::Base
    register Sinatra::Index
    set :public_folder, File.expand_path('_site', Dir.pwd)
    use_static_index 'index.html'
  end
end
