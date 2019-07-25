# test_booking_system_rest

### Configuration

    $ docker-compose build
    $ docker-compose up

### Database creation

    $ docker-compose run web rake db:create

### Database initialization

    $ docker-compose run web rake db:migrate

### How to run the test suite

    $ docker-compose run web rspec

### Linting

    $ docker-compose run web rubocop
