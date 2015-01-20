class JekyllAuth
  class JekyllSite < Sinatra::Base


    def four_oh_four
      path if File.exists?(path)
    end

    register Sinatra::Index
    set :public_folder, File.expand_path('_site', Dir.pwd)
    use_static_index 'index.html'

    not_found do
      status 404
      four_oh_four = File.expand_path('_site/404.html', Dir.pwd)
      File.read(four_oh_four) if File.exists?(four_oh_four)
    end
  end
end
