require 'nokogiri'
require 'elasticsearch'
require 'json'

# Elasticsearch Configuration
es_host = ENV['ELASTICSEARCH_URL']
es_api_key = ENV['ELASTICSEARCH_API_KEY']
index_name = 'data-ecom.developer-3' # or another name if you prefer

# Setup Elasticsearch client
client = Elasticsearch::Client.new(
  url: es_host,
  transport_options: {
    headers: { Authorization: "ApiKey #{es_api_key}" }
  },
  verify_elasticsearch: false
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

  title_element = doc.at_css('title')
  content_element = doc.at_css('body')

  # Check if the elements are not nil before extracting text
  title = title_element ? title_element.text : "Unknown Title"
  content = content_element ? content_element.text.strip : "No Content"

  document = {
    id: html_file,
    url: "/#{html_file.sub('./_site/', '')}",
    title: title,
    text: content
  }

  client.index(index: index_name, id: document[:id], body: document)
end
