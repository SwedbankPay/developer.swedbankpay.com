# frozen_string_literal: true

require 'jekyll'
require 'liquid'
require 'kramdown'

module SwedbankPay
  # A Liquid tag for rendering an internal link only if the linked file exists
  class CLinkBlock < Liquid::Block
    def initialize(tag_name, args, tokens)
      super

      doc = Kramdown::Document.new(args)
      doc.root.children = find_paragraph_children(doc.root)
      @text = doc.to_html
    end

    def render(context)
      url = super
      uri = URI(url)
      source_directory = context.registers[:site].config['source']

      unless uri.absolute? || relative_file_exists?(uri, source_directory)
        Jekyll.logger.debug 'CLink:', "<#{uri}> is absolute, or the relative path does not exist."
        return @text
      end

      "<a href=\"#{url}\">#{@text}</a>"
    rescue StandardError => e
      Jekyll.logger.error 'CLink:', e
      @text
    end

    private

    def relative_file_exists?(uri, source_directory)
      path = File.join(source_directory, uri.path)

      if File.exist?(path)
        Jekyll.logger.debug 'CLink:', "File exists: #{path}"
        return true
      end

      path += '.md'
      if File.exist?(path)
        Jekyll.logger.debug 'CLink:', "File exists: #{path}"
        return true
      end

      Jekyll.logger.debug 'CLink:', "File does not exists: #{path}"
      false
    rescue StandardError => e
      Jekyll.logger.error 'CLink:', e
      false
    end

    def find_paragraph_children(element)
      return element.children if element.type == :p

      element.children.each do |child|
        children = find_paragraph_children(child)
        return children if children
      end

      element.children
    end
  end
end

Liquid::Template.register_tag('clink', SwedbankPay::CLinkBlock)
