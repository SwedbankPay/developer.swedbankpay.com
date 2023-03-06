# frozen_string_literal: true

require 'html-proofer'
require 'html-proofer-unrendered-markdown'
require 'concurrent'

# Swedbank Pay module
module SwedbankPay
  # Verifies the built HTML with HTMLProofer
  class Verifier
    def initialize(auth_token, log_level: :info)
      @log_level = log_level
      @auth_token = auth_token
    end

    def verify(path)
      ensure_directory_not_empty!(path)

      proofer = HTMLProofer.check_directory(path, options)
      @logger = proofer.logger

      @logger.log(:info, "Checking '#{path}' with HTMLProofer")

      proofer.before_request { |request| before_request(request) }
      proofer.run
    end

    private

    def before_request(request)
      uri = URI(request.base_url)

      unless uri.host.match('github\.(com|io)$')
        @logger.log(:info, "No authorization set for <#{uri}> as it's not matching github.com or github.io.")
        return
      end

      auth = "Bearer #{@auth_token}"
      request.options[:headers]['Authorization'] = auth
      @logger.log(:info, "Authorization set for <#{uri}>.")
    end

    def ensure_directory_not_empty!(dir)
      html_glob = File.join(dir, '**/*.html')
      raise "#{dir} contains no .html files" if Dir.glob(html_glob).empty?
    end

    def options
      o = default_options
      o[:typheous] = { verbose: true } if @log_level == :debug
      o
    end

    def default_options
      {
        cache: { timeframe: { external: '1w' } },
        check_html: true,
        check_unrendered_link: true,
        checks: %w[Links Images Scripts UnrenderedLink],
        allow_missing_href: true,
        enforce_https: true,
        log_level: @log_level,
        only_4xx: true,
        disable_external: true,
        parallel: { in_processes: Concurrent.processor_count },
        ignore_urls: [
          'https://api.payex.com/',
          'https://appstore.com',
          'http://www.wikipedia.org',
          'https://zend18.zendesk.com/hc/en-us/articles/219131697-HowTo-Implement-TLS-1-2-Support-with-the-cURL-PHP-Extension-in-Zend-Server',
          'https://blogs.oracle.com/java/post/jdk-8-will-use-tls-12-as-default'
        ]
      }
    end
  end
end
