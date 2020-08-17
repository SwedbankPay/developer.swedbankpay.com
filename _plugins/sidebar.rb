# frozen_string_literal: false

require 'jekyll'
require 'nokogiri'
require 'json'

###
# This plugin works only if used as a remote-theme
# If included as a theme or gem this plugin must be copied over
###

module Jekyll
  class Sidebar
    attr_accessor :hash_pre_render
    attr_accessor :filename_with_headers

    def initialize
      @hash_pre_render = {}
      @filename_with_headers = {}
    end

    def pre_render(page)
      menu_order = page['menu-order'].nil? ? 0 : page['menu-order']
      hide_from_sidebar = page['hide_from_sidebar'].nil? ? false : page['hide_from_sidebar']
      url = page['url'].gsub('index.html', '').gsub('.html', '')
      @hash_pre_render[url] = {
        title: page['title'],
        url: page['url'].gsub('.html', ''),
        name: page['name'],
        menu_order: menu_order,
        hide_from_sidebar: hide_from_sidebar
      }
    end

    def post_write(site)
      files = []
      Dir.glob("#{site.config['destination']}/**/*.html") do |filename|
        doc = File.open(filename) { |f| Nokogiri::HTML(f) }
        files.push(doc)

        headers = []
        doc.xpath('//h2 ').each do |header|
          next unless header['id']

          child = header.last_element_child
          header = {
            id: header['id'],
            title: header.content.strip,
            hash: (child['href']).to_s
          }
          headers.push(header)
        end
        sanitized_filename = sanitize_filename(filename)
        @filename_with_headers[sanitized_filename] = { headers: headers }
      end

      Dir.glob("#{site.config['destination']}/**/*.html") do |filename|
        sanitized_filename = sanitize_filename(filename)
        sidebar = render(sanitized_filename)
        file = File.open(filename) { |f| Nokogiri::HTML(f) }
        file.xpath('//*[@id="dx-sidebar-main-nav-ul"]').each do |location|
          location.inner_html = sidebar
        end
        File.open(filename, 'w') { |f| f.write(file.to_html(encoding: 'UTF-8')) }
      end
    end

    private

    def sanitize_filename(filename)
      sanitized_filename = filename.match(/(?m)(?<=\b_site).*$/)[0]
      sanitized_filename = sanitized_filename.gsub('index.html', '')
      sanitized_filename.gsub('.html', '')
    end

    def generateSubgroup(filename, key, value, all_subgroups, level)
      title = value[:title].split('–').last
      subsubgroup_list = all_subgroups.select do |subsubgroup_key, _subsubgroup_value|
        subsubgroup_key.include? key and subsubgroup_key != key and \
          key.split('/').length > level
      end

      subgroup = ''
      has_subgroups = !all_subgroups.empty?
      if value[:headers].any? || !subsubgroup_list.empty?
        if has_subgroups
          url = value[:url]
          active = active?(filename, url, true)
          # puts "#{url}, #{filename}, #{key}" if active
          item_class = active || (url.split('/').length > level && filename.start_with?(url)) ? 'nav-subgroup active' : 'nav-subgroup'
          subgroup << "<li class=\"#{item_class}\">"
          subgroup << "<div class=\"nav-subgroup-heading\"><i class=\"material-icons\">arrow_right</i><a href=\"#{url}\">#{title}</a></div>"
          subgroup << '<ul class="nav-ul">'

          if subsubgroup_list.empty?
            value[:headers].each do |header|
              subgroup << "<li class=\"nav-leaf\"><a href=\"#{value[:url]}#{header[:hash]}\">#{header[:title]}</a></li>"
            end
          else
            subgroup_leaf_class = active ? 'nav-leaf nav-subgroup-leaf active' : 'nav-leaf nav-subgroup-leaf'
            subgroup << "<li class=\"#{subgroup_leaf_class}\"><a href=\"#{value[:url]}\">#{title} overview</a></li>"

            subsubgroup_list.each do |subsubgroup_key, subsubgroup_value|
              subgroup << generateSubgroup(filename, subsubgroup_key, subsubgroup_value, subsubgroup_list, 3)
            end
          end

          subgroup << '</ul>'
          subgroup << '</li>'
        else
          value[:headers].each do |header|
            subgroup << "<li class=\"nav-leaf\"><a href=\"#{value[:url]}#{header[:hash]}\">#{header[:title]}</a></li>"
          end
        end
      else
        subgroup << if has_subgroups
                      "<li class=\"nav-leaf nav-subgroup-leaf\"><a href=\"#{value[:url]}\">#{title}</a></li>"
                    else
                      "<li class=\"nav-leaf\"><a href=\"#{value[:url]}\">#{title}</a></li>"
                    end
      end

      subgroup
    end

    def render(filename)
      sidebar = ''

      merged = merge(@hash_pre_render, @filename_with_headers).sort_by { |_key, value| value[:menu_order] }
      merged.select { |key, _value| key.split('/').length <= 2 }.each do |key, value|
        next if value[:title].nil?
        next if value[:hide_from_sidebar]

        subgroups = merged.select { |subgroup_key, _subgroup_value| subgroup_key.include? key and subgroup_key != key and key != '/' }

        active = active?(filename, key)
        item_class = active ? 'nav-group active' : 'nav-group'

        child = "<li class=\"#{item_class}\">"
        child << "<div class=\"nav-group-heading\"><i class=\"material-icons\">arrow_right</i><span>#{value[:title].split('–').first}</span></div>"

        child << '<ul class="nav-ul">'

        subgroup = generateSubgroup(filename, key, value, subgroups, 2)

        child << subgroup

        if subgroups.any?
          subgroups.select { |subgroup_key, _subgroup_value| subgroup_key.split('/').length <= 3 }.each do |subgroup_key, subgroup_value|
            subgroup = generateSubgroup(filename, subgroup_key, subgroup_value, subgroups, 2)
            child << subgroup
          end
        end

        child << '</ul>'
        child << '</li>'
        sidebar << child
      end

      File.open('_site/sidebar.html', 'w') { |f| f.write(sidebar) }
      sidebar
    end

    def active?(filename, url, exact = false)
      if filename == '/' || url == '/'
        if filename == '/' && url == '/'
          return true
        else
          return false
        end
      end

      exact ? filename == url : filename.start_with?(url)
    end

    def merge(hash1, hash2)
      all_keys = hash1.keys | hash2.keys
      result_hash = {}

      all_keys.each do |key|
        hash_value = {}

        if hash1.key? key
          value = hash1[key]

          hash_value = value unless value.nil?
        end

        if hash2.key? key
          value = hash2[key]

          hash_value = hash_value.merge(value) unless value.nil?
        end

        result_hash[key] = hash_value
      end

      result_hash
    end
  end
end

sidebar = Jekyll::Sidebar.new

Jekyll::Hooks.register :site, :pre_render do |site, _payload|
  site.pages.each do |page|
    sidebar.pre_render page
  end
end

Jekyll::Hooks.register :site, :post_write do |site|
  sidebar.post_write site
end
