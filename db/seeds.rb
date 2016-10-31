# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin Users
AdminUser.create!(
  email: ENV['ADMIN_USER_EMAIL'],
  password: ENV['ADMIN_USER_PASSWORD'],
  password_confirmation: ENV['ADMIN_USER_PASSWORD']
)

# Categories
Category.create!(name: 'promocional')
Category.create!(name: 'competitiva')

# Locations
Location.create(name: 'Pigüé')
Location.create(name: 'Carhué')
Location.create(name: 'Casbas')
Location.create(name: 'Daireaux')
Location.create(name: 'Salliqueló')
Location.create(name: 'Tres Lomas')
Location.create(name: 'Huanguelén')
Location.create(name: 'Guaminí')

# Participants
if Rails.env.development?
  Participant.create(
    firstname: 'Pablo Antonio',
    lastname: 'Cascio',
    birthdate: Date.parse('19-01-1971'),
    identification_number: '21345678',
    identification_type: :DNI,
    location: Location.where(name: 'Pigüé').first
  )
end
