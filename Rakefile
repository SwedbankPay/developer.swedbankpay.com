# coding: utf-8
require "jekyll"
require "html-proofer"

# Extend string to allow for bold text.
class String
  def bold
    "\033[1m#{self}\033[0m"
  end

  def safe_strip
    value = self.frozen? ? self.dup : self
    value.strip!
    value
  end
end

# Get environment variable or fallback to the provided git command
def get_env(key, fallback_git_command)
  if ENV.has_key?(key)
    value = ENV[key].safe_strip
    puts "Environment variable #{key} used with value: #{value}."
  else
    value = `git #{fallback_git_command}`.safe_strip
    puts "No Environment variable for #{key} found. Fallback Git command provided the value: #{value}."
  end

  value
end

# Rake Jekyll tasks
task :build do
  git_branch = get_env("GITHUB_BRANCH", "rev-parse --abbrev-ref HEAD")
  git_repo_url = get_env("GITHUB_REPOSITORY_URL", "config --get remote.origin.url")

  # Translate from SSH to HTTPS URL.
  /^git\@github\.com\:(?<repo_name>.*)\.git$/.match(git_repo_url) do |match|
    repo_name = match[:repo_name]
    git_repo_url = "https://github.com/#{repo_name}"
  end

  git_parent_commits = `git show --no-patch --format="%P"`.split(" ")

  if git_parent_commits.length > 1
    # We have more than 1 parent, so this is a merge-commit
    puts "Merge-commit detected. Finding parents."

    git_parent_branches = git_parent_commits.map do |git_parent_commit|
      git_parent_branch = `git describe --contains --always --all --exclude refs/tags/ #{git_parent_commit}`
      git_parent_branch.strip!

      unless git_parent_branch.include?("~")
        git_parent_branch
      end
    end

    git_branch = git_parent_branches.compact.first
  else
    puts "No merge commit, moving along with branch '#{git_branch}'."
  end

  puts "Building Jekyll site (#{git_repo_url}, #{git_branch})...".bold

  options = {
    "github" => {
      "branch" => git_branch,
    },
    "profile" => true,
  }

  options["github"]["repository_url"] = git_repo_url unless git_repo_url.empty?

  Jekyll::Commands::Build.process(options)
end

task :clean do
  puts "Cleaning up _site...".bold
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
      "http://restcookbook.com/Basics/loggingin/",
    ],
  }
  HTMLProofer.check_directory("./_site", options).run
end

task :default => ["build"]
