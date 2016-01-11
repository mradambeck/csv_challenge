require './models/person_importer'
require './models/person'

# Environment Setup
ENV['DATABASE_URL'] = "csv_challenge_sql_default"

# Database Schema
conn = PG.connect(dbname: ENV['DATABASE_URL'])

# See postgresql column datatypes:
# http://www.postgresql.org/docs/9.5/static/datatype.html
out = conn.exec(
  "DROP TABLE people;
   CREATE TABLE people (
      id                serial,
      first_name        varchar(40),
      last_name         varchar(40),
      middle_initial    varchar(1),
      gender            varchar(6),
      date_of_birth     date,
      favorite_color    varchar(40)
  )"
)

batch_import_configs = [
  {
    filename: "sample/comma.txt",
    delimeter: "comma",
    headers: [:last_name, :first_name, :gender, :favorite_color, :date_of_birth]
  },
  {
    filename: "sample/pipe.txt",
    delimeter: "pipe",
    headers: [:last_name, :first_name, :middle_initial, :gender, :favorite_color, :date_of_birth]
  },
  {
    filename: "sample/space.txt",
    delimeter: "space",
    headers: [:last_name, :first_name, :middle_initial, :gender, :date_of_birth, :favorite_color]
  }
]

batch_import_configs.each do |config|
  importer = PersonImporter.new(config)
  importer.each_row do |row_data|
    Person.create(row_data)
  end
end

puts "Output 1:"
puts Person.render(:sort_by_gender)

puts "\r\n"
puts "Output 2:"
puts Person.render(:sort_by_birth)

puts "\r\n"
puts "Output 3:"
puts Person.render(:sort_by_last_name_descending)

