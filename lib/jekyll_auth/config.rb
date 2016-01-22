class JekyllAuth
  def self.config_file
    File.join(Dir.pwd, '_config.yml')
  end

  def self.config
    @config ||= begin
      config = YAML.safe_load_file(config_file)
      config['jekyll_auth'] || {}
    rescue
      {}
    end
  end

  def self.whitelist
    whitelist = JekyllAuth.config['whitelist']
    Regexp.new(whitelist.join('|')) unless whitelist.nil?
  end

  def self.whitelist_teams
    JekyllAuth.config
      .select {|k,_| k =~ /^team_\d+$/ }
      .inject({}) {|h, (k, whitelist)|
        h[k.sub('team_', '')] = Regexp.new(whitelist.join('|'))
        h
      }
  end

  def self.ssl?
    !!JekyllAuth.config['ssl']
  end
end
