# frozen_string_literal: true

source 'https://rubygems.org'

ruby '~> 2.7'

group :jekyll_plugins do
  # Necessary to prevent Jekyll errors. See https://github.com/github/personal-website/issues/166
  gem 'faraday', '~> 2.7.0'
  gem 'jekyll', '~> 4.3'
  gem 'jekyll-material-icon-tag'
  gem 'jekyll-redirect-from'
  gem 'jemoji'
  gem 'kramdown', '>= 2.3'
  gem 'kramdown-plantuml', '>= 1.3'
  gem 'rouge', '>= 4.0.1'
  gem 'searchyll', git: 'https://github.com/SwedbankPay/searchyll.git'
  gem 'swedbank-pay-design-guide-jekyll-theme', '1.16.2'
end

group :test do
  gem 'html-proofer', '>= 4'
  gem 'html-proofer-unrendered-markdown', '>= 0.2'
  gem 'octokit', '>= 6.0.1'
  gem 'rake', '>= 13'
  gem 'rspec', '>= 3'
  gem 'rubocop', '>= 1'
  gem 'rubocop-rake', '>= 0.6'
end
