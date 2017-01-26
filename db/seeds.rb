# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: 'seed_user@example.com', password: 'password')
100.times do |c|
  u = User.find_by(email: 'seed_user@example.com')
  license = [*('a'..'z'),*('0'..'9')].shuffle[0,7].join
  GeoTagVehicle.create!(
    make: 'Toyota',
    model: 'Celica',
    color: 'Black',
    license_plate: license,
    latitude: 47.6188363,
    longitude: -122.321937,
    state: 'WA',
    additional_info: 'Lost Car',
    user: u
  )
end
