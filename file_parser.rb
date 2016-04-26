
require 'csv'
comma_values = CSV.read('sample/comma.txt')
pipe_values = CSV.read('sample/pipe.txt', { :col_sep => '|' })
space_values = CSV.read('sample/space.txt', { :col_sep => ' ' })

# p "comma:"
# p comma_values
#
# p "pipe:"
# p pipe_values
#
# p "space"
# p space_values

@people = Array.new

# @people = Hash.new
#
comma_values.each do |line|
  person = Hash.new
  person[:last_name] = line[0]
  person[:first_name] = line[1]
  person[:gender] = line[2]
  person[:color] = line[3]
  person[:date] = line[4]
  @people << person
end

pipe_values.each do |line|
  person = Hash.new
  person[:last_name] = line[0].strip
  person[:first_name] = line[1].strip
  person[:middle_initial] = line[2].strip
  if line[3].strip == "M"
    person[:gender] = "Male"
  elsif line[3].strip == "F"
    person[:gender] = "Female"
  end
  person[:color] = line[4].strip
  person[:date] = line[5].strip
  @people << person
end

space_values.each do |line|
  person = Hash.new
  person[:last_name] = line[0]
  person[:first_name] = line[1]
  person[:middle_initial] = line[2]
  if line[3] == "M"
    person[:gender] = "Male"
  elsif line[3] == "F"
    person[:gender] = "Female"
  end
  person[:date] = line[4]
  person[:color] = line[5]
  @people << person
end

puts @people
