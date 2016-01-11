require './database'
require './models/person_importer'
require './models/person'

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

