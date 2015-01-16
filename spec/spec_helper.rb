require "bundler/setup"
require 'fileutils'

$:.push File.join(File.dirname(__FILE__), '..', 'lib')

require 'pp'
require 'rack/test'
require_relative "../lib/jekyll-auth"

def tmp_dir
  File.expand_path "../tmp", File.dirname(__FILE__)
end

def tear_down_tmp_dir
  FileUtils.rm_rf tmp_dir
end

def setup_tmp_dir
  tear_down_tmp_dir
  FileUtils.mkdir tmp_dir
  Dir.chdir tmp_dir
end
