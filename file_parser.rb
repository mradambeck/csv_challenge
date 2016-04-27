require 'csv'
comma_values = CSV.read('sample/comma.txt')
pipe_values = CSV.read('sample/pipe.txt', { :col_sep => '|' })
space_values = CSV.read('sample/space.txt', { :col_sep => ' ' })

# splits date into array,
# sets month & day as 2 digit numbers if single digits,
# then combines all into mm/dd/yyyy format

def date_parse(arr, str)
  date = arr.strip.split(/[\/\-]/)
  ( date[0] = '0' + date[0].to_s ) if ( date[0].length < 2 )
  ( date[1] = '0' + date[1].to_s ) if ( date[1].length < 2 )
  return date[0]+'/'+date[1]+'/'+date[2]
end

# changes 'M' to 'Male' & 'F' to 'Female'
def gender_parse(str)
  return str.strip if str.strip.length >=4
  str.strip.upcase == "M" ? "Male" : "Female"
end

# TAKE EACH FILE AND PUSH EACH PERSON TO ARRAY AS OBJECTS
@people = Array.new

comma_values.each do |line|
  person = Hash.new
  person[:last_name] = line[0].strip
  person[:first_name] = line[1].strip
  person[:gender] = gender_parse(line[2])
  person[:color] = line[3].strip
  person[:date] = date_parse(line[4])
  @people << person
end

pipe_values.each do |line|
  person = Hash.new
  person[:last_name] = line[0].strip
  person[:first_name] = line[1].strip
  person[:middle_initial] = line[2].strip
  person[:gender] = gender_parse(line[3])
  person[:color] = line[4].strip
  person[:date] = date_parse(line[5])
  @people << person
end

space_values.each do |line|
  person = Hash.new
  person[:last_name] = line[0].strip
  person[:first_name] = line[1].strip
  person[:middle_initial] = line[2].strip
  person[:gender] = gender_parse(line[3])
  person[:date] = date_parse(line[4])
  person[:color] = line[5].strip
  @people << person
end


# OUTPUT
def output_people(person)
  puts "#{person[:last_name]} #{person[:first_name]} #{person[:gender]} #{person[:date]} #{person[:color]}"
end

# Output 1:
@people.sort_by{ |p| [p[:gender], p[:last_name]] }.each do |person|
  output_people(person)
end

puts "--------------"

# Output 2:
@people.sort_by{ |p| p[:date][-4..-1] }.each do |person|
  output_people(person)
end

puts "--------------"

# Output 3:
@people.sort_by{ |p| p[:last_name] }.reverse.each do |person|
  output_people(person)
end
