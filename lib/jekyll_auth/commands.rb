class JekyllAuth
  class Commands

    FILES = %w{Rakefile config.ru .gitignore .env}

    def self.source
      @source ||= File.expand_path( "../../templates", File.dirname(__FILE__) )
    end

    def self.destination
      @destination ||= Dir.pwd
    end

    def self.changed?
      execute_command("git", "status", destination, "--porcelain").length != 0
    rescue
      false
    end

    def self.execute_command(*args)
      output, status = Open3.capture2e(*args)
      raise "Command `#{args.join(" ")}` failed: #{output}" if status != 0
      output
    end

    def self.copy_templates
      FILES.each do |file|
        if File.exist? "#{destination}/#{file}"
          puts "* #{destination}/#{file} already exists... skipping."
        else
          puts "* creating #{destination}/#{file}"
          FileUtils.cp "#{source}/#{file}", "#{destination}/#{file}"
        end
      end
    end

    def self.team_id(org, team)
      client = Octokit::Client.new :access_token => ENV["GITHUB_TOKEN"]
      client.auto_paginate = true
      teams = client.organization_teams org
      found = teams.find { |t| t[:slug] == team }
      found[:id] if found
    end

    def self.env_var_set?(var)
      !(ENV[var].to_s.blank?)
    end
  end
end
