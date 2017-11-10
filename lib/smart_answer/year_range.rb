module SmartAnswer
  class YearRange < DateRange
    def initialize(begins_on:)
      ends_on = begins_on - 1 + 1.year
      if ends_on.month == 2 && ends_on.day == 28 && ends_on.leap?
        ends_on += 1
      end
      super(begins_on: begins_on, ends_on: ends_on)
    end

    def self.with_fixed_day_and_month(start_date)
      year_range_class = Class.new(YearRange) do
        def self.starting_day=(day)
          @starting_day = day
        end

        def self.starting_day
          @starting_day
        end

        def self.starting_month=(month)
          @starting_month = month
        end

        def self.starting_month
          @starting_month
        end

        def self.current
          on(Date.today)
        end

        def self.on(date)
          year_range = new(begins_in: date.year)
          year_range.include?(date) ? year_range: year_range.previous
        end

        def initialize(begins_in:)
          super(begins_on: Date.new(begins_in, self.class.starting_month, self.class.starting_day))
        end

        def previous
          self.class.new(begins_in: begins_on.year - 1)
        end
      end

      year_range_class.tap do |y|
        date = Date.parse(start_date.to_s)
        y.starting_month = date.month
        y.starting_day = date.day
      end
    end
  end
end
