# frozen_string_literal: true

require 'liquid'

# Jekyll module
module SwedbankPay
  # A Liquid tag for rendering flags
  class FlagTag < Liquid::Tag
    def initialize(tag_name, country_code, tokens)
      super
      @country_code = country_code
    end

    def render(_)
      "<i class=\"flag-icon flag-icon-#{@country_code}\"></i>"
    end
  end
end

Liquid::Template.register_tag('flag', SwedbankPay::FlagTag)
