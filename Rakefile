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
  git_branch = `git rev-parse --abbrev-ref HEAD`
  git_branch.strip!

  if git_branch == 'HEAD' then
    git_branch = `git describe --contains --always --all`
    git_branch.strip!
  end

  puts "Building Jekyll site (#{git_branch})...".bold

  options = {
    "github" => {
      "branch" => git_branch
    },
    "profile" => true
  }

  Jekyll::Commands::Build.process(options)
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
    :check_unrendered_link => true,
    :url_ignore => [
      "https://blogs.oracle.com/java-platform-group/jdk-8-will-use-tls-12-as-default",
      "http://restcookbook.com/Basics/loggingin/"
    ]
  }
  HTMLProofer.check_directory("./_site", options).run
end

task :default => ["build"]
