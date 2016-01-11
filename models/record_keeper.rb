require 'pg'
require 'active_support/inflector' # String#pluralize method

class RecordKeeper
  class Base

    attr_accessor :id

    @@all = []
    @@conn = PG.connect(dbname: ENV['DATABASE_URL'] || "csv_challenge_sql_default")

    def initialize(args={})
      @@table_name ||= self.class.to_s.downcase.pluralize
      post_initialize(args)
      @id = args[:id] || nil
      add_person
    end

    def post_initialize(args) # subclasses may override
      nil
    end

    def save
      joined_keys = keys.join(", ")
      joined_placeholders = (1..keys.count).map {|v| "$#{v}"}.join(", ")
      res = @@conn.exec_params(
        "INSERT into #{@@table_name} ( #{joined_keys} )
          VALUES ( #{ joined_placeholders })
          RETURNING id",
            values
      )
      self.id = res[0]["id"]
      self
    end

    def self.create(args={})
      new(args).save
    end

    def self.all
      @@all
    end

    def self.find(args={})
      # assumes order of keys in hash will be same as order of values
      joined_query = args.keys.map.with_index {|k,index| "#{k} = $#{index+1}"}.join(", ")
      res = @@conn.exec_params("SELECT * from #{@@table_name} WHERE (#{joined_query})", args.values)
      res.map {|row| new(row) }
    end

    private

    def add_person
      @@all << self
    end

  end
end
