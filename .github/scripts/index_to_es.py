import os
import json
from glob import glob
from bs4 import BeautifulSoup
from elasticsearch import Elasticsearch
import openai

# Elasticsearch Configuration
es_host = os.getenv('ELASTICSEARCH_URL')
es_api_key = os.getenv('ELASTICSEARCH_API_KEY')
index_name = 'data-ecom.developer-6' # or another name if you prefer

# OpenAI Configuration
openai.api_key = os.getenv('OPENAI_EMBEDDING_API_KEY')

# Setup Elasticsearch client
client = Elasticsearch(
    es_host,
    headers={"Authorization": f"ApiKey {es_api_key}"}
)

# Ensure the index exists
try:
    client.indices.create(index=index_name)
except Exception as e:
    if 'resource_already_exists_exception' in str(e):
        print("Index already exists, skipping creation.")
    else:
        raise

def get_embeddings(text):
    response = openai.Embedding.create(
        model="text-embedding-3-small",
        input=text
    )
    embeddings = response['data'][0]['embedding']
    return embeddings

def extract_content_from_html(html_content):
    soup = BeautifulSoup(html_content, 'html.parser')
    content = ' '.join(soup.stripped_strings)
    return content

# Iterate over generated HTML files and index them
for html_file in glob('./_site/checkout-v3/**/*.html'):
    with open(html_file, 'r', encoding='utf-8') as file:
        doc_content = file.read()
    title = BeautifulSoup(doc_content, 'html.parser').title.string if BeautifulSoup(doc_content, 'html.parser').title else "Unknown Title"
    content = extract_content_from_html(doc_content)

    embedding = get_embeddings(content)

    document = {
        'id': html_file,
        'url': f"/{html_file.replace('./_site/', '')}",
        'title': title,
        'text': content,
        'embedding': embedding
    }

    client.index(index=index_name, id=document['id'], body=document)

print("Indexing completed.")
