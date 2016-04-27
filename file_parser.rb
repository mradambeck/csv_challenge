require 'csv'
comma_values = CSV.read('sample/comma.txt')
pipe_values = CSV.read('sample/pipe.txt', { :col_sep => '|' })
space_values = CSV.read('sample/space.txt', { :col_sep => ' ' })

# splits date into array,
# sets month & day as 2 digit numbers if single digits,
# then combines all into mm/dd/yyyy format

def date_parse(arr)
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


@people = Array.new

# TAKE EACH FILE ENTRY AND PUSH TO ARRAY AS HASH
def person_parser (values)
  values.each do |line|
    person = Hash.new
    person[:last_name] = line[0].strip
    person[:first_name] = line[1].strip

    # checks with file it's being sent
    if line.length < 6
      person[:gender] = gender_parse(line[2])
      person[:color] = line[3].strip
      person[:date] = date_parse(line[4])
    else
      person[:middle_initial] = line[2].strip
      person[:gender] = gender_parse(line[3])

      # checks with file it's being sent
      if ( line[4][-4].to_i  !=  0 )
        person[:date] = date_parse(line[4])
        person[:color] = line[5].strip
      else
        person[:color] = line[4].strip
        person[:date] = date_parse(line[5])
      end
    end
    @people << person
  end
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


person_parser(pipe_values)
person_parser(space_values)
person_parser(comma_values)
