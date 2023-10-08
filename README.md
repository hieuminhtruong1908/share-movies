In the root directory
- Run docker compose up
Run spec:
- docker compose run app rspec --format documentation
Run rubocop:
- docker compose run app rubocop 


## Install development

```bash
docker compose build
docker compose run
## Import database
# Move db file to folder tmp (ex: tmp/dump_db.sql)
docker compose run app bash
app# apt-get install -y postgresql-client
app# psql -h db -U medme kindercare_dev < tmp/dump_db.sql
```

for mysql:
docker compose run app bash
app# mysql -h db -u root -p share_movies < db/dump/test.sql



## Run and debug
```bash
# Run
docker compose up
# Debug (for byebug)
docker attach kindercare-web-1
docker attach kindercare-sidekiq-1
# Reindex
docker compose run web bundle exec rake searchkick:reindex:all
docker compose run web bundle exec rake admin_tool:reindex_skip_error # for qa database
```
