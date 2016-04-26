
require 'csv'
comma_values = CSV.read('sample/comma.txt')
pipe_values = CSV.read('sample/pipe.txt', { :col_sep => '|' })
space_values = CSV.read('sample/space.txt', { :col_sep => ' ' })

p "comma:"
p comma_values

p "pipe:"
p pipe_values

p "space"
p space_values

@people = Hash.new

comma_values.each do |line|

end
