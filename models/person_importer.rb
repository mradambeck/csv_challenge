require 'csv'

class PersonImporter

  attr_reader :filename, :options

  SEPERATORS = {
      "space" => "\s",
      "comma" => ",\s",
      "pipe" => "\s|\s"
  }

  def initialize(config)
    @filename = config[:filename]
    @options  = {
      col_sep: seperator( config[:delimeter] ),
      headers: config[:headers]
    }
  end

  def each_row(&block)
    CSV.open(filename, options).each do |row|
      block.call( normalized(row) )
    end
  end

  private

  def normalized(row)
    hash = row.to_h
    hash[:gender] = normalize_gender(hash[:gender])
    hash[:date_of_birth] = normalize_dob(hash[:date_of_birth])
    hash
  end

  def normalize_gender(gender)
    return nil if not gender
    return "Male" if gender.match(/(M|Male)/i)
    return "Female" if gender.match(/(F|Female)/i)
    nil
  end

  def normalize_dob(dob)
    return nil if not dob
    dob.gsub!('/','-')
    Date.strptime(dob, '%m-%d-%Y').strftime("%Y-%m-%d")
  end

  def seperator(name)
    SEPERATORS[name]
  end

end
