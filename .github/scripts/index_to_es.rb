require 'nokogiri'
require 'elasticsearch'
require 'json'

# Elasticsearch Configuration
es_host = ENV['ELASTICSEARCH_URL']
es_api_key = ENV['ELASTICSEARCH_API_KEY']
index_name = 'data-ecom.developer-6' # or another name if you prefer

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

def extract_content_from_html(html_content)
  nokogiri_doc = Nokogiri::HTML(html_content)
  content = nokogiri_doc.xpath('//article//text()').to_s.gsub(/\s+/, ' ')
  content
end

# Iterate over generated HTML files and index them
Dir.glob('./_site/checkout-v3/**/*.html').each do |html_file|
  doc_content = File.read(html_file)
  title = Nokogiri::HTML(doc_content).at_css('title')&.text || "Unknown Title"
  content = extract_content_from_html(doc_content)

  document = {
    id: html_file,
    url: "/#{html_file.sub('./_site/', '')}",
    title: title,
    text: content
  }

  client.index(index: index_name, id: document[:id], body: document)
end
