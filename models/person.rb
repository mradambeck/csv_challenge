require 'date'
require './models/record_keeper'

class Person < RecordKeeper::Base

  attr_reader :last_name, :first_name, :middle_initial, :gender, :favorite_color

  def post_initialize(args={})
    @last_name      = args[:last_name]
    @first_name     = args[:first_name]
    @middle_initial = args[:middle_initial]
    @gender         = normalize_gender( args[:gender] )
    @dob            = normalize_dob( args[:date_of_birth] )
    @favorite_color = args[:favorite_color]
  end

  # instance methods

  def date_of_birth(date_format="%-m/%-d/%Y")
    @dob.strftime(date_format)
  end

  def inspect
    "#{last_name} #{first_name} #{gender} #{date_of_birth} #{favorite_color}"
  end

  # class methods

  def self.sort_by_last_name
    all.sort_by{|person| person.last_name}
  end

  def self.sort_by_last_name_descending
    sort_by_last_name.reverse
  end

  def self.sort_by_birth
    all.sort_by{|person| person.date_of_birth("%Y/%m/%d")}
  end

  def self.sort_by_gender
    groupings = sort_by_last_name.group_by{|person| person.gender }
    groupings['Female'] + groupings['Male']
  end

  def self.render(sort=:all)
    self.send(sort).map { |item| item.inspect }.join("\r\n")
  end

  private

  def normalize_gender(gender)
    return nil if not gender
    return "Male" if gender.match(/(M|Male)/i)
    return "Female" if gender.match(/(F|Female)/i)
    nil
  end

  def normalize_dob(date_of_birth)
    return nil if not date_of_birth
    DateTime.strptime(date_of_birth.gsub('-','/'), '%m/%d/%Y')
  end

end
