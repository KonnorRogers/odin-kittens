# README

Practice working with APIs. Guidance provided by:
[TheOdinProject working with APIs](https://www.theodinproject.com/courses/ruby-on-rails/lessons/apis)

## Ruby version
2.6.2

## System dependencies
* Docker-ce
* Docker-compose
* Rails 5.2.3

## Getting started

```bash
# builds the image
docker-compose build

# create the database
docker-compose run web rails db:create
docker-compose run web rails db:migrate

# runs the server locally on port 3000
docker-compose up

# runs the test suite
docker-compose run --rm web rails test
docker-compose exec web rails test # Only works if container is 'up'

# run a pry session
docker-compose run web rails console
docker-compose exec web rails console


# turns the container off
docker-compose down
```

