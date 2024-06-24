import os
from pathlib import Path
from bs4 import BeautifulSoup
from elasticsearch import Elasticsearch
import openai

# Elasticsearch Configuration
es_host = os.getenv('ELASTICSEARCH_URL')
es_api_key = os.getenv('ELASTICSEARCH_API_KEY')
index_name = 'data-ecom.developer-6'  # or another name if you prefer

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

def get_embedding(text, model="text-embedding-3-small"):
   text = text.replace("\n", " ")
   return openai.embeddings.create(input = [text], model=model).data[0].embedding

def extract_content_from_html(html_content):
    soup = BeautifulSoup(html_content, 'html.parser')
    content = ' '.join(soup.stripped_strings)
    return content

# Iterate over generated HTML files and index 
html_files = Path('./_site/checkout-v3').rglob('*.html')
for html_file in html_files:
    print(f"Indexing {html_file}...")
    with open(html_file, 'r', encoding='utf-8') as file:
        doc_content = file.read()
    title = BeautifulSoup(doc_content, 'html.parser').title.string if BeautifulSoup(doc_content, 'html.parser').title else "Unknown Title"
    content = extract_content_from_html(doc_content)

    #if content is longer than 10000 characters, split it into chunks based on 15000 characters and then find nearest whitespace to split the content
    if len(content) > 20000:
        print(f"Content is too long, splitting into chunks...")
        chunks = [content[i:i+20000] for i in range(0, len(content), 20000)]
    else:
        chunks = [content]
        doc_id = html_file
    for i, chunk in enumerate(chunks):
        embedding = get_embedding(chunk)
        doc_id = f"{html_file}_{i}"

        document = {
            'id': doc_id,
            'url': f"/{html_file.replace('./_site/', '')}",
            'title': title,
            'text': chunk,
            'embedding': embedding
        }
        client.index(index=index_name, id=document['id'], body=document)
        print(f"Indexed {document['id']}")

print("Indexing completed.")
