require 'nokogiri'
require 'elasticsearch'
require 'json'

# Elasticsearch Configuration
es_host = ENV['ELASTICSEARCH_URL']
es_api_key = ENV['ELASTICSEARCH_API_KEY']
index_name = 'jekyll' # or another name if you prefer

# Setup Elasticsearch client
client = Elasticsearch::Client.new(
  url: es_host,
  transport_options: {
    headers: { Authorization: "ApiKey #{es_api_key}" }
  }
)

# Ensure the index exists
begin
  client.indices.create(index: index_name)
rescue Elasticsearch::Transport::Transport::Errors::BadRequest => e
  puts "Index already exists, skipping creation."
end

# Iterate over generated HTML files and index them
Dir.glob('./_site/**/*.html').each do |html_file|
  doc = Nokogiri::HTML(File.read(html_file))

  title = doc.at_css('title').text
  content = doc.at_css('body').text.strip

  document = {
    id: html_file,
    url: "/#{html_file.sub('./_site/', '')}",
    title: title,
    text: content
  }

  client.index(index: index_name, id: document[:id], body: document)
end