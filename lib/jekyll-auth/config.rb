class JekyllAuth
  def self.setup_config
  	config_file_path = File.join(Dir.pwd, "_config.yml")
  	config_file = YAML.safe_load_file(config_file_path)
  	config_file
  end

  def self.config
    @config ||= JekyllAuth.setup_config
  end

  def self.whitelist
    jekyll_auth_key = JekyllAuth::config["jekyll_auth"]
    return nil if !jekyll_auth_key or !(whitelist = jekyll_auth_key["whitelist"])
    Regexp.new(whitelist.join("|"))
  end
end
