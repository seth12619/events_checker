# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby/Rails version
  - Ruby 3.2.2
  - Rails 7.0.8.6

* Configuration
  - DB port is set to 5433, you can change port number to your local configuration's port in database.yml

* Database creation
  - Developed using postgresql 17

* Database initialization
  - rails db:drop
  - rails db:create
  - rails db:migrate
  - rails db:seed

* How to run the test suite
  - bundle exec rspec spec

* 2 ways to run the application's event checker
  1. Via rails console
    - bundle exec rails c
    - Event.non_overlapping_available

  2. Via url
    - bundle exec rails s
    - visit the url: http://localhost:3000/events/non_overlapping_events
