class RecordKeeper
  class Base

    @@all = []

    def initialize(*args)
      post_initialize(*args)
      add_person
    end

    def self.all
      @@all
    end

    def post_initialize(args) # subclasses may override
      nil
    end

    private

    def add_person
      @@all << self
    end

  end
end
