require 'csv'
require 'date'

def csv_to_records_arr file_path, delimiter
  records = []
  CSV.foreach(file_path, {col_sep: delimiter}) do |line|
    records << csv_line_to_record_hash(line)
  end
  records
end

def csv_line_to_record_hash(line)
  record = {}
  record[:last_name] = line[0].strip! || line[0]
  record[:first_name] = line[1].strip!
  record[:gender] = line[2].strip!
  record[:favorite_color] = line[3].strip!
  record[:date_of_birth] = line[4].strip!
  record
end

records = csv_to_records_arr "./sample/comma.txt", ","
# p records

def sort_by_last_desc records_arr
  records_arr.sort do | a, b |
    b[:last_name] <=> a[:last_name]
  end
  records_arr
end

# p sort_by_last_desc records

def str_to_date str
  mdy = str.split('/')
  Date.new(mdy[2].to_i, mdy[0].to_i, mdy[1].to_i)
end


def sort_by_date_asc records_arr
  records_arr.sort do | a, b |
    str_to_date(a[:date_of_birth]) <=> str_to_date(b[:date_of_birth])
  end
end

# p sort_by_date_asc records

def sort_by_gender_last_asc records_arr
  records_arr.sort do | a, b |
    if a[:gender] < b[:gender]
      -1
    elsif a[:gender] > b[:gender]
      1
    else
      a[:last_name] <=> b[:last_name]
    end
  end
end

# p sort_by_gender_last_asc records

def convert_to_arr record
  arr = []
  arr << record[:last_name]
  arr << record[:first_name]
  arr << record[:gender]
  arr << record[:date_of_birth]
  arr << record[:favorite_color]
  arr
end

def puts_output records_arr
  space = "\s"
  option_1 = sort_by_gender_last_asc records_arr
  option_2 = sort_by_date_asc records_arr
  option_3 = sort_by_last_desc records_arr

  puts "\nOption 1:\n"
  option_1.each do |record|
    puts convert_to_arr(record).join(' ')
  end
  puts "\nOption 2:\n"
  option_2.each do |record|
    puts convert_to_arr(record).join(' ')
  end
  puts "\nOption 3:\n"
  option_3.each do |record|
    puts convert_to_arr(record).join(' ')
  end
end

puts_output records
