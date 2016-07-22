class JekyllAuth
  def self.config_file
    File.join(Dir.pwd, '_config.yml')
  end

  def self.jekyllConfig
    @config ||= begin
      jekyllConfig = YAML.safe_load_file(config_file)
    rescue
      {}
    end
  end

  def self.destination
    @config ||= begin
      JekyllAuth.jekyllConfig['destination'] || '_site'
    rescue
      {}
    end
  end

  def self.config
    @config ||= begin
      JekyllAuth.jekyllConfig['jekyll_auth'] || {}
    rescue
      {}
    end
  end

  def self.whitelist
    whitelist = JekyllAuth.jekyllConfig['whitelist']
    Regexp.new(whitelist.join('|')) unless whitelist.nil?
  end

  def self.ssl?
    !!JekyllAuth.jekyll_config['ssl']
  end
end
