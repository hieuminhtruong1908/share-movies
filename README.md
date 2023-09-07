In the root directory
#Run app
- docker compose up -d
#Run spec:
- docker compose run app rspec --format documentation
#Run rubocop:
- docker compose run app rubocop 
