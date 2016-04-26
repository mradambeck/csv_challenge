# f = File.open("sample/comma.txt", "r")
# f.each_line do |line|
#   puts line
# end
# f.close
#
# f = File.open("sample/pipe.txt", "r")
# f.each_line do |line|
#   puts line
# end
# f.close
#
# f = File.open("sample/space.txt", "r")
# f.each_line do |line|
#   puts line
# end
# f.close
#

require 'csv'
comma_values = CSV.read('/sample/comma.txt')
pipe_values = CSV.read('/sample/pipe.txt')
space_values = CSV.read('/sample/space.txt')
