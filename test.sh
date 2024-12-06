#!/bin/bash

set -e

# To clear possible old index
curl -s -H "Content-Type: application/json" -X DELETE "http://localhost:9200/lemmagen-test" > /dev/null

echo -e "--------------- CREATE INDEX ---------------\n"
curl -f -H "Content-Type: application/json" -X PUT "http://localhost:9200/lemmagen-test" -d '{
 "settings": {
   "index": {
     "analysis": {
       "filter": {
         "lemmagen_filter_en": {
           "type": "lemmagen",
           "lexicon": "en"
         }
       },
       "analyzer": {
         "lemmagen_en": {
           "type": "custom",
           "tokenizer": "uax_url_email",
           "filter": [
             "lemmagen_filter_en"
           ]
         }
       }
     }
   }
 },
 "mappings": {
   "properties": {
     "text": {
       "type": "text",
       "analyzer": "lemmagen_en"
     }
   }
 }
}'

echo -e "\n"
echo -e "--------------- ANALYZE TEXT ---------------\n"
curl -f -H "Content-Type: application/json" -X GET "http://localhost:9200/lemmagen-test/_analyze" -d '
{
  "text": "I am late.",
  "analyzer": "lemmagen_en"
}'

echo -e "\n"
echo -e "--------------- INDEX DOCUMENT ---------------\n"
curl -f -H "Content-Type: application/json" -X PUT "http://localhost:9200/lemmagen-test/_doc/1?refresh=wait_for" -d '
{
  "user": "tester",
  "published_at": "2013-11-15T14:12:12",
  "text": "I am late."
}'


echo -e "\n"
echo -e "--------------- SEARCH DOCUMENT ---------------\n"
curl -f -H "Content-Type: application/json" -X GET "http://localhost:9200/lemmagen-test/_search" -d '
{
  "query": {
    "match": {
      "text": "is"
    }
  }
}'

echo -e "\n"
echo -e "--------------- DELETE INDEX ---------------\n"
curl -f -H "Content-Type: application/json" -X DELETE "http://localhost:9200/lemmagen-test"

echo -e "\n"
echo -e "👍 ALL DONE 👍\n"
