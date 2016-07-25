class JekyllAuth
  def self.config_file
    File.join(Dir.pwd, '_config.yml')
  end

  def self.jekyll_config
    @config ||= begin
      jekyll_config = YAML.safe_load_file(config_file)
    rescue
      {}
    end
  end

  def self.destination
    @config ||= begin
      JekyllAuth.jekyll_config['destination'] || '_site'
    rescue
      {}
    end
  end

  def self.config
    @config ||= begin
      JekyllAuth.jekyll_config['jekyll_auth'] || {}
    rescue
      {}
    end
  end

  def self.whitelist
    whitelist = JekyllAuth.jekyll_config['whitelist']
    Regexp.new(whitelist.join('|')) unless whitelist.nil?
  end

  def self.ssl?
    !!JekyllAuth.jekyll_config['ssl']
  end
end