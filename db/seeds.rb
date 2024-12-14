# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Event.create!([
  { event_type: 'booked', start_time: '2018-12-19 16:00:00', end_time: '2018-12-19 17:00:00' },
  { event_type: 'booked', start_time: '2018-12-20 09:00:00', end_time: '2018-12-20 10:00:00' },
  { event_type: 'booked', start_time: '2018-12-21 13:00:00', end_time: '2018-12-21 13:30:00' },
  { event_type: 'available', start_time: '2018-12-19 16:00:00', end_time: '2018-12-19 17:00:00' },
  { event_type: 'available', start_time: '2018-12-20 09:30:00', end_time: '2018-12-20 11:30:00' },
  { event_type: 'available', start_time: '2018-12-28 13:00:00', end_time: '2018-12-28 15:00:00' },
  { event_type: 'available', start_time: '2018-12-29 13:00:00', end_time: '2018-12-29 14:00:00' }
])