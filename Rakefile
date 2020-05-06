# coding: utf-8
require 'jekyll'
require 'html-proofer'

# Extend string to allow for bold text.
class String
  def bold
    "\033[1m#{self}\033[0m"
  end
end

# Rake Jekyll tasks
task :build do
  puts 'Building site...'.bold
  Jekyll::Commands::Build.process(profile: true)
end

task :clean do
  puts 'Cleaning up _site...'.bold
  Jekyll::Commands::Clean.process({})
end

# Test generated output has valid HTML and links.
task :test => :build do
  options = {
              :assume_extension => true,
              :check_html => true,
              :enforce_https => true,
              :only_4xx => true,
              :check_unrendered_link => true
            }
  HTMLProofer.check_directory("./_site", options).run
end

task :default => ["build"]
