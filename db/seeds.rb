# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def random_hour(from, to)
  (Date.today + rand(from..to).hour + rand(0..60).minutes).strftime("%H:%M")
end

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
  name: 'A',
  age_start: 14,
  age_end: 35,
  genre: :f
)
subcat.categories << [promocional, competitiva]
subcat.save

subcat = Subcategory.create!(
  name: 'B',
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

subcat = Subcategory.create!(
  name: 'Elite',
  age_start: 19,
  age_end: 29,
  genre: :m
)
subcat.categories << competitiva
subcat.save

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
  name: 'A',
  age_start: 19,
  age_end: 35,
  genre: :m
)
subcat.categories << promocional
subcat.save

subcat = Subcategory.create!(
  name: 'B',
  age_start: 36,
  age_end: 50,
  genre: :m
)
subcat.categories << promocional
subcat.save

subcat = Subcategory.create!(
  name: 'C',
  age_start: 51,
  age_end: 100,
  genre: :m
)
subcat.categories << promocional
subcat.save

# Locations
pigue = Location.create(name: 'Pigüé')
pellegrini = Location.create(name: 'Pellegrini')
casbas = Location.create(name: 'Casbas')
carhue = Location.create(name: 'Carhué')
daireaux = Location.create(name: 'Daireaux')
coronel_suarez = Location.create(name: 'Coronel Suarez')
salliquelo = Location.create(name: 'Salliqueló')
tres_lomas = Location.create(name: 'Tres Lomas')
huanguelen = Location.create(name: 'Huanguelén')
guamini = Location.create(name: 'Guaminí')

if Rails.env.development?
  # Championships
  championship = Championship.create!(
    name: "Rural Bike (Sudoeste Pcia. Buenos Aires)",
    year: 2017,
    description: "this is a description"
  )

  # Schedules
  Schedule.create!(
    number: 1,
    date: Date.parse('10-04-2017'),
    start_time: Time.parse("15:00"),
    description: "",
    location: pigue,
    championship: championship
  )
  Schedule.create!(
    number: 2,
    date: Date.parse('08-05-2017'),
    start_time: Time.parse("15:00"),
    description: "",
    location: carhue,
    championship: championship
  )
  Schedule.create!(
    number: 3,
    date: Date.parse('05-06-2017'),
    start_time: Time.parse("15:00"),
    description: "",
    location: casbas,
    championship: championship
  )
  Schedule.create!(
    number: 4,
    date: Date.parse('03-07-2017'),
    start_time: Time.parse("15:00"),
    description: "",
    location: daireaux,
    championship: championship
  )
  Schedule.create!(
    number: 5,
    date: Date.parse('07-08-2017'),
    start_time: Time.parse("15:00"),
    description: "",
    location: salliquelo,
    championship: championship
  )
  Schedule.create!(
    number: 6,
    date: Date.parse('04-09-2017'),
    start_time: Time.parse("15:00"),
    description: "",
    location: tres_lomas,
    championship: championship
  )
  Schedule.create!(
    number: 7,
    date: Date.parse('25-09-2017'),
    start_time: Time.parse("15:00"),
    description: "",
    location: huanguelen,
    championship: championship
  )
  Schedule.create!(
    number: 8,
    date: Date.parse('23-10-2017'),
    start_time: Time.parse("15:00"),
    description: "",
    location: guamini,
    championship: championship
  )

  (1..8).each do |i|
    Race.create!(
      kms: 55,
      lasts: 5,
      category: competitiva,
      schedule_id: i,
    )
    Race.create!(
      kms: 33,
      lasts: 3,
      category: promocional,
      schedule_id: i,
    )
  end

  # Participants
  maleNames = [
    "Gomez Luna Mauricio",
    "Pablo Antonio Cascio",
    "Iriarte Gaston",
    "Jeger Hector",
    "Torres Juan",
    "Barbagelata Jose L.",
    "Rodriguez Jorge",
    "Marquez Miguel",
    "Lopez Ariel",
    "Ruiz De Erenchun Ezequiel",
    "Burrieza Eduardo",
    "Balercia Amilcar",
    "Guevara Bernardo",
    "Lochbaum Rodolfo",
    "Graff Eduardo",
    "Jaramillo Hector",
    "Lamas Ruben",
    "Agis Fernando",
    "Rojo Javier",
    "Casali Diego",
    "Peña Carlos",
    "Madroñal Diego",
    "Astudillo Miguel",
    "Bahl Eduardo",
    "Buffarini Sandro",
    "Laplace Facundo",
    "Giubengia Gabriel",
    "Vera Isidro",
    "Yungblut Anibal",
    "Vergara Abelardo",
    "Gartner Gabriel",
    "Scasso Fabian",
    "Buckle Gustavo"
  ].each do |fullname|
    first, last = fullname.split
    date = Date.parse("#{rand(1..27)}-#{rand(1..12)}-#{rand(1968..1972)}")
    Participant.create(
      firstname: first,
      lastname: last,
      genre: :m,
      category: competitiva,
      birthdate: date,
      identification_number: 10000000 + rand(99999999),
      identification_type: [:DNI, :LE, :LC].sample,
      location: Location.order("RAND()").first
    )
  end

  femaleNames = [
    "Marti Mirna",
    "Perez Julieta",
    "Vera Sosa Guillermina",
    "Felix Jimena"
  ].each do |fullname|
    first, last = fullname.split
    date = "#{rand(1..27)}-#{rand(1..12)}-#{rand(1982..2002)}"
    Participant.create(
      firstname: first,
      lastname: last,
      genre: :f,
      category: promocional,
      birthdate: Date.parse(date),
      identification_number: 10000000 + rand(99999999),
      identification_type: [:DNI, :LE, :LC].sample,
      location: Location.order("RAND()").first
    )
  end

  # Assign all participants to current championship
  championship.participants << Participant.all
  championship.save

  # Create random results
  Championship.current.schedules.each do |schedule|
    schedule.races.each do |race|
      results = []
      number = 100
      Participant.where(category: race.category).each do |p|
        number += 1
        absent = [true, false].sample
        finished = absent ? false : [true, false].sample
        pnumber = number unless absent
        time = (random_hour(1,2) if finished) unless absent
        # add result to array
        results << Result.new(
          time: time,
          participant: p,
          participant_number: pnumber,
          finished: finished,
          absent: absent,
          race: race
        )
      end
      # results grouped by subcategory
      results
        .group_by {|r| r.participant.subcategory.name.parameterize}
        .each {|sc, res| Result.sync(res) }
    end
  end

end
