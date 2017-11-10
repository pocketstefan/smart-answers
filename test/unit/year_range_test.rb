require_relative '../test_helper'

module SmartAnswer
  class YearRangeTest < ActiveSupport::TestCase
    context 'not including the 29th Feb of a leap year' do
      setup do
        @year_range = YearRange.new(begins_on: Date.parse('2000-03-01'))
      end

      should 'begin on begins_on date' do
        assert_equal Date.parse('2000-03-01'), @year_range.begins_on
      end

      should 'end a day before a year after the begins_on date' do
        assert_equal Date.parse('2001-02-28'), @year_range.ends_on
      end

      should 'be 365 days long, because it does not include 29th Feb' do
        assert_equal 365, @year_range.number_of_days
      end
    end

    context 'including the 29th Feb of a leap year' do
      setup do
        @year_range = YearRange.new(begins_on: Date.parse('2000-02-01'))
      end

      should 'end a day before a year after the begins_on date' do
        assert_equal Date.parse('2001-01-31'), @year_range.ends_on
      end

      should 'be 366 days long, because it does include 29th Feb' do
        assert_equal 366, @year_range.number_of_days
      end
    end

    context 'beginning on 29th February of a leap year' do
      setup do
        @year_range = YearRange.new(begins_on: Date.parse('2000-02-29'))
      end

      should 'end a day before a year after the begins_on date' do
        assert_equal Date.parse('2001-02-28'), @year_range.ends_on
      end

      should 'be 366 days long, because it does include 29th Feb' do
        assert_equal 366, @year_range.number_of_days
      end
    end

    context 'ending on 29th February of a leap year' do
      setup do
        @year_range = YearRange.new(begins_on: Date.parse('1999-03-01'))
      end

      should 'end a day before a year after the begins_on date' do
        assert_equal Date.parse('2000-02-29'), @year_range.ends_on
      end

      should 'be 366 days long, because it does include 29th Feb' do
        assert_equal 366, @year_range.number_of_days
      end
    end

    context 'creating ranges with fixed starting day and month' do
      should 'not overwrite previously declared classes' do
        Feb1Year = YearRange.with_fixed_day_and_month("1 Feb")
        Mar15Year = YearRange.with_fixed_day_and_month("15 Mar")

        feb_1_year = Feb1Year.current
        assert_equal 1, feb_1_year.begins_on.day
        assert_equal 2, feb_1_year.begins_on.month

        mar_15_year = Mar15Year.current
        assert_equal 15, mar_15_year.begins_on.day
        assert_equal 3, mar_15_year.begins_on.month
      end
    end
  end
end
