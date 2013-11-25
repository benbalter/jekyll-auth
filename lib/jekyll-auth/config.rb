class JekyllAuth
  def self.setup_config
  	@config_file ||= YAML.safe_load_file(File.join(Dir.pwd, "_config.yml"))
  end

  def self.config
    config_file = JekyllAuth.setup_config
    return {} if config_file.nil? || config_file["jekyll_auth"].nil?
    config_file["jekyll_auth"]
  end

  def self.whitelist
    whitelist = JekyllAuth::config["whitelist"]
    Regexp.new(whitelist.join("|")) unless whitelist.nil?
  end

  def self.ssl?
    !!JekyllAuth::config["ssl"]
  end
end
