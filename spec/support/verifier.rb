# frozen_string_literal: true

require 'html-proofer'
require 'html-proofer-unrendered-markdown'
require 'concurrent'

# Swedbank Pay module
module SwedbankPay
  # Verifies the built HTML with HTMLProofer
  class Verifier
    def initialize(auth_token)
      @auth_token = auth_token
    end

    def verify(path)
      ensure_directory_not_empty!(path)

      puts "Checking '#{path}' with HTMLProofer"

      proofer = HTMLProofer.check_directory(path, options)
      proofer.before_request { |request| before_request(request) }
      proofer.run
    end

    private

    def before_request(request)
      uri = URI(request.base_url)

      unless uri.host.match('github\.(com|io)$')
        puts "No authorization set for <#{uri}> as it's not matching github.com or github.io."
        return
      end

      auth = "Bearer #{@auth_token}"
      request.options[:headers]['Authorization'] = auth
      puts "Authorization set for <#{uri}>."
    end

    def ensure_directory_not_empty!(dir)
      html_glob = File.join(dir, '**/*.html')
      raise "#{dir} contains no .html files" if Dir.glob(html_glob).empty?
    end

    def options
      {
        cache: { timeframe: { external: '1w' } },
        check_html: true,
        check_unrendered_link: true,
        checks: %w[Links Images Scripts UnrenderedLink],
        enforce_https: true,
        log_level: :debug,
        only_4xx: true,
        parallel: { in_processes: Concurrent.processor_count },
        typheous: { verbose: true },
        url_ignore: [
          'http://www.wikipedia.org',
          'http://restcookbook.com/Basics/loggingin/'
        ]
      }
    end
  end
end
