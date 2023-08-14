# parse_html.rb
require 'nokogiri'
require 'json'

html_file_path = ARGV[0]

doc = Nokogiri::HTML(File.open(html_file_path))

title = doc.at_css('title').text
content = doc.at_css('body').text

# Add more metadata extraction as needed

puts({
  id: html_file_path,
  url: "/#{html_file_path.sub('./_site/', '')}",
  text: content.strip,
  title: title.strip
}.to_json)
