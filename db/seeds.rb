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
promocional = Category.create!(name: 'promocional')
competitiva = Category.create!(name: 'competitiva')

# Subcategories

## Promocional & Competitiva
subcat = Subcategory.create!(
  name: 'Damas A',
  age_start: 19,
  age_end: 35,
  genre: :f
)
subcat.categories << [promocional, competitiva]
subcat.save

subcat = Subcategory.create!(
  name: 'Damas B',
  age_start: 36,
  age_end: 100,
  genre: :f
)
subcat.categories << [promocional, competitiva]
subcat.save

## Only competitiva
subcat = Subcategory.create!(
  name: 'Sub 18',
  age_start: 14,
  age_end: 18,
  genre: :m
)
subcat.categories << competitiva
subcat.save

# subcat = Subcategory.create!(
#   name: 'Sub 18',
#   age_start: 14,
#   age_end: 18,
#   genre: :f
# )
# subcat.categories << competitiva
# subcat.save

subcat = Subcategory.create!(
  name: 'Elite',
  age_start: 19,
  age_end: 29,
  genre: :m
)
subcat.categories << competitiva
subcat.save

# subcat = Subcategory.create!(
#   name: 'Elite',
#   age_start: 19,
#   age_end: 29,
#   genre: :f
# )
# subcat.categories << competitiva
# subcat.save

subcat = Subcategory.create!(
  name: 'Master A1',
  age_start: 30,
  age_end: 34,
  genre: :m
)
subcat.categories << competitiva
subcat.save

subcat = Subcategory.create!(
  name: 'Master A2',
  age_start: 35,
  age_end: 39,
  genre: :m
)
subcat.categories << competitiva
subcat.save

subcat = Subcategory.create!(
  name: 'Master B1',
  age_start: 40,
  age_end: 44,
  genre: :m
)
subcat.categories << competitiva
subcat.save

subcat = Subcategory.create!(
  name: 'Master B2',
  age_start: 45,
  age_end: 49,
  genre: :m
)
subcat.categories << competitiva
subcat.save

subcat = Subcategory.create!(
  name: 'Master C1',
  age_start: 50,
  age_end: 54,
  genre: :m
)
subcat.categories << competitiva
subcat.save

subcat = Subcategory.create!(
  name: 'Master C2',
  age_start: 55,
  age_end: 59,
  genre: :m
)
subcat.categories << competitiva
subcat.save

subcat = Subcategory.create!(
  name: 'Master D1',
  age_start: 60,
  age_end: 64,
  genre: :m
)
subcat.categories << competitiva
subcat.save

subcat = Subcategory.create!(
  name: 'Master D2',
  age_start: 65,
  age_end: 100,
  genre: :m
)
subcat.categories << competitiva
subcat.save

## Only Promocional
subcat = Subcategory.create!(
  name: 'Caballeros A',
  age_start: 14,
  age_end: 35,
  genre: :m
)
subcat.categories << promocional
subcat.save

subcat = Subcategory.create!(
  name: 'Caballeros B',
  age_start: 36,
  age_end: 50,
  genre: :m
)
subcat.categories << promocional
subcat.save

subcat = Subcategory.create!(
  name: 'Caballeros C',
  age_start: 51,
  age_end: 100,
  genre: :m
)
subcat.categories << promocional
subcat.save

# Locations
Location.create(name: 'Pigüé')
Location.create(name: 'Carhué')
Location.create(name: 'Casbas')
Location.create(name: 'Daireaux')
Location.create(name: 'Salliqueló')
Location.create(name: 'Tres Lomas')
Location.create(name: 'Huanguelén')
Location.create(name: 'Guaminí')

if Rails.env.development?
  # Participants
  Participant.create(
    firstname: 'Pablo Antonio',
    lastname: 'Cascio',
    genre: :m,
    category: competitiva,
    birthdate: Date.parse('19-01-1971'),
    identification_number: '21345678',
    identification_type: :DNI,
    location: Location.where(name: 'Pigüé').first
  )
  # Championships
  Championship.create!(
    name: "Rural Bike (Sudoeste Pcia. Buenos Aires)",
    year: 2016,
    description: "this is a description"
  )
end
