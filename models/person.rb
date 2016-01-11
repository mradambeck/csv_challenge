require 'date'
require './models/record_keeper'

class Person < RecordKeeper::Base

  attr_reader :last_name, :first_name, :middle_initial, :gender, :favorite_color

  def post_initialize(args={})
    @last_name      = args[:last_name]
    @first_name     = args[:first_name]
    @middle_initial = args[:middle_initial]
    @gender         = args[:gender]
    @date_of_birth  = args[:date_of_birth]
    @favorite_color = args[:favorite_color]
  end

  # instance methods

  def date_of_birth(date_format="%-m/%-d/%Y")
    Date.strptime(@date_of_birth, "%Y-%m-%d").strftime(date_format)
  end

  def inspect
    "#{last_name} #{first_name} #{gender} #{date_of_birth} #{favorite_color}"
  end

  def keys
    ["first_name", "middle_initial", "last_name", "gender", "date_of_birth", "favorite_color"]
  end

  def values
    [@first_name, @middle_initial, @last_name, @gender, @date_of_birth, @favorite_color]
  end

  # class methods

  def self.sort_by_last_name
    #TODO: Switch to SQL Queries
    all.sort_by{|person| person.last_name}
  end

  def self.sort_by_last_name_descending
    #TODO: Switch to SQL Queries
    sort_by_last_name.reverse
  end

  def self.sort_by_birth
    #TODO: Switch to SQL Queries
    all.sort_by{|person| person.date_of_birth("%Y/%m/%d")}
  end

  def self.sort_by_gender
    #TODO: Switch to SQL Queries
    groupings = sort_by_last_name.group_by{|person| person.gender }
    groupings['Female'] + groupings['Male']
  end

  def self.render(sort=:all)
    self.send(sort).map { |item| item.inspect }.join("\r\n")
  end

end
