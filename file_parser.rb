
require 'csv'
comma_values = CSV.read('sample/comma.txt')
pipe_values = CSV.read('sample/pipe.txt', { :col_sep => '|' })
space_values = CSV.read('sample/space.txt', { :col_sep => ' ' })

# p "comma:"
# p comma_values

# p "pipe:"
# p pipe_values

# p "space"
# p space_values

@people = Array.new

comma_values.each do |line|
  person = Hash.new
  person[:last_name] = line[0].strip
  person[:first_name] = line[1].strip
  person[:gender] = line[2].strip
  person[:color] = line[3].strip
  date = line[4].strip
  person[:month] = date.split('/')[0]
  person[:day] = date.split('/')[1]
  person[:year] = date.split('/')[2]
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
  date = line[5].strip
  person[:month] = date.split('-')[0]
  person[:day] = date.split('-')[1]
  person[:year] = date.split('-')[2]
  @people << person
end

space_values.each do |line|
  person = Hash.new
  person[:last_name] = line[0].strip
  person[:first_name] = line[1].strip
  person[:middle_initial] = line[2].strip
  if line[3].strip == "M"
    person[:gender] = "Male"
  elsif line[3].strip == "F"
    person[:gender] = "Female"
  end
  date = line[4].strip
  person[:month] = date.split('-')[0]
  person[:day] = date.split('-')[1]
  person[:year] = date.split('-')[2]
  person[:color] = line[5].strip
  @people << person
end

# puts @people

# Output 1:
@people.sort_by{ |p| [p[:gender], p[:last_name]] }.each do |person|
  puts "#{person[:last_name]} #{person[:first_name]} #{person[:gender]} #{person[:month]}/#{person[:day]}/#{person[:year]} #{person[:color]}"
end

puts "--------------"

# Output 2:
@people.sort_by{ |p| p[:year] }.each do |person|
  puts "#{person[:last_name]} #{person[:first_name]} #{person[:gender]} #{person[:month]}/#{person[:day]}/#{person[:year]} #{person[:color]}"
end

puts "--------------"

# Output 3:
@people.sort_by{ |p| p[:last_name] }.reverse.each do |person|
  puts "#{person[:last_name]} #{person[:first_name]} #{person[:gender]} #{person[:month]}/#{person[:day]}/#{person[:year]} #{person[:color]}"
end
