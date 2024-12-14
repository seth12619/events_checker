# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby/Rails version
- Ruby 3.2.2
- Rails 7.0.8.6

* System dependencies

* Configuration

* Database creation
- Developed using postgresql 17

* Database initialization
- rails db:drop
- rails db:create
- rails db:migrate
- rails db:seed

* How to run the test suite
- bundle exec rspec spec

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
2 ways to run the application's event checker
1. Via rails console
  - rails c
  - Event.non_overlapping_available

2. Via url
  - rails s
  - visit the url: http://localhost:3000/events/non_overlapping_events
