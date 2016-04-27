require 'csv'
comma_values = CSV.read('sample/comma.txt')
pipe_values = CSV.read('sample/pipe.txt', { :col_sep => '|' })
space_values = CSV.read('sample/space.txt', { :col_sep => ' ' })

def date_parse(arr, str)
  date = arr.strip.split(str)
  ( date[0] = '0' + date[0].to_s ) if ( date[0].length < 2 )
  ( date[1] = '0' + date[1].to_s ) if ( date[1].length < 2 )
  return date[0]+'/'+date[1]+'/'+date[2]
end

def gender_parse(str)
  if str.strip.upcase == "M"
    return "Male"
  else
    return "Female"
  end
end

@people = Array.new

comma_values.each do |line|
  person = Hash.new
  person[:last_name] = line[0].strip
  person[:first_name] = line[1].strip
  person[:gender] = line[2].strip
  person[:color] = line[3].strip
  person[:date] = date_parse(line[4],'/')
  @people << person
end

pipe_values.each do |line|
  person = Hash.new
  person[:last_name] = line[0].strip
  person[:first_name] = line[1].strip
  person[:middle_initial] = line[2].strip
  person[:gender] = gender_parse(line[3])
  person[:color] = line[4].strip
  person[:date] = date_parse(line[5],'-')
  @people << person
end

space_values.each do |line|
  person = Hash.new
  person[:last_name] = line[0].strip
  person[:first_name] = line[1].strip
  person[:middle_initial] = line[2].strip
  person[:gender] = gender_parse(line[3])
  person[:date] = date_parse(line[4],'-')
  person[:color] = line[5].strip
  @people << person
end

# output_template = person[:last_name]+' '+person[:first_name]+' '+person[:gender]+' '+person[:color]


# Output 1:
@people.sort_by{ |p| [p[:gender], p[:last_name]] }.each do |person|
  puts "#{person[:last_name]} #{person[:first_name]} #{person[:gender]} #{person[:date]} #{person[:color]}"
end

puts "--------------"

# Output 2:
@people.sort_by{ |p| p[:date][-4..-1] }.each do |person|
  puts "#{person[:last_name]} #{person[:first_name]} #{person[:gender]} #{person[:date]} #{person[:color]}"
end

puts "--------------"

# Output 3:
@people.sort_by{ |p| p[:last_name] }.reverse.each do |person|
  puts "#{person[:last_name]} #{person[:first_name]} #{person[:gender]} #{person[:date]} #{person[:color]}"
end
