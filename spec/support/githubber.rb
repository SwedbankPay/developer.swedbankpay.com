# frozen_string_literal: true

require 'octokit'

module SwedbankPay
  class Githubber
    def initialize
      github_token = ENV['GITHUB_TOKEN']
      github_context_env = ENV['GITHUB_CONTEXT']

      raise 'GITHUB_TOKEN is not set' if github_token.nil? || github_token.empty?
      raise 'GITHUB_CONTEXT is not set' if github_context_env.nil? || github_context_env.empty?

      @octokit = Octokit::Client.new(access_token: github_token)
      @github_context = JSON.parse(github_context_env)
    end

    def create_pull_request_review(message, filename, line_number)
      repo = @github_context['repository']
      pr_number = @github_context['event']['number']

      raise 'Could not find repository' if repo.nil? || repo.empty?
      raise 'Could not find pull request number' if pr_number.nil? || pr_number.zero?

      comments = [{ path: filename, position: line_number, body: message }]
      options = { event: 'REQUEST_CHANGES', comments: comments }

      puts "Creating pull request review for #{filename}:#{line_number} in #{repo}##{pr_number}."

      # TODO: For some reason, the API call below fails with the following error:
      #   POST https://api.github.com/repos/SwedbankPay/developer.swedbankpay.com/pulls/1711/reviews:
      #     422 - Unprocessable Entity
      #   Error summary:
      #     Pull request review thread position is invalid and Pull request review
      #     thread diff hunk can't be blank
      #     // See: https://docs.github.com/rest/reference/pulls#create-a-review-for-a-pull-request
      @octokit.create_pull_request_review(repo, pr_number, options)
    end
  end
end
