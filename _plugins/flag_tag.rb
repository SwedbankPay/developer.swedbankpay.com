require "liquid"

module Jekyll
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

Liquid::Template.register_tag("flag", Jekyll::FlagTag)
