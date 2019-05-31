# README


## Ruby version
2.6.2

## System dependencies
Docker-ce
Docker-compose
Rails 5.2.3

## Getting started

```bash
# builds the image
docker-compose build

# create the database
docker-compose run web rails db:migrate

# runs the test suite
docker-compose -f docker-compose.test.yml run web --rm web

# runs the server locally on port 3000
docker-compose up

# turns the container off
docker-compose down
```

