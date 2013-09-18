class JekyllAuth
  class JekyllSite < Sinatra::Base
    register Sinatra::Index
    set :public_folder, '_site'
    use_static_index 'index.html'
  end
end
