require 'rspec'
require 'date'
require './date_range_formatter'

#require 'spec_helper'

describe DateRangeFormatter do  
  it "formats date range for the same day" do
    formatter = DateRangeFormatter.new "2009-11-1", "2009-11-1"
    formatter.to_s.should == "1st November 2009"
  end
  
  it "formats date range for the same day with starting time" do
    formatter = DateRangeFormatter.new "2009-11-1", "2009-11-1", "10:00"
    formatter.to_s.should == "1st November 2009 at 10:00"
  end
  
  it "formats date range for the same day with starting and ending times" do
    formatter = DateRangeFormatter.new "2009-11-1", "2009-11-1", "10:00", "11:00"
    formatter.to_s.should == "1st November 2009 at 10:00 to 11:00"
  end
  
  it "formats date range for the same month" do
    formatter = DateRangeFormatter.new "2009-11-1", "2009-11-3"
    formatter.to_s.should == "1st - 3rd November 2009"
  end
  
  it "formats date range for the same month with starting time" do
    formatter = DateRangeFormatter.new "2009-11-1", "2009-11-3", "10:00"
    formatter.to_s.should == "1st November 2009 at 10:00 - 3rd November 2009"
  end
  
  it "formats date range for the same month with starting and ending times" do
    formatter = DateRangeFormatter.new "2009-11-1", "2009-11-3", "10:00", "11:00"
    formatter.to_s.should == "1st November 2009 at 10:00 - 3rd November 2009 at 11:00"
  end
  
  it "formats date range for the same year" do
    formatter = DateRangeFormatter.new "2009-11-1", "2009-12-1"
    formatter.to_s.should == "1st November - 1st December 2009"
  end
  
  it "formats date range for the same year with starting time" do
    formatter = DateRangeFormatter.new "2009-11-1", "2009-12-1", "10:00"
    formatter.to_s.should == "1st November 2009 at 10:00 - 1st December 2009"
  end
  
  it "formats date range for the same year with starting and ending times" do
    formatter = DateRangeFormatter.new "2009-11-1", "2009-12-1", "10:00", "11:00"
    formatter.to_s.should == "1st November 2009 at 10:00 - 1st December 2009 at 11:00"
  end
  
  it "formats date range for different year" do
    formatter = DateRangeFormatter.new "2009-11-1", "2010-12-1"
    formatter.to_s.should == "1st November 2009 - 1st December 2010"
  end


  it "formats date range for different year with starting time" do
    formatter = DateRangeFormatter.new "2009-11-1", "2010-12-1", "10:00"
    formatter.to_s.should == "1st November 2009 at 10:00 - 1st December 2010"
  end
  
  it "should give long date range for different year with starting and ending times" do
    formatter = DateRangeFormatter.new "2009-11-1", "2010-12-1", "10:00", "11:00"
    formatter.to_s.should == "1st November 2009 at 10:00 - 1st December 2010 at 11:00"
  end
  
end





# class DateRangeFormatter
  
#   attr_reader :start_on, :end_on, :starting_time, :ending_time
  
#   def initialize start_on, end_on, starting_time = nil, ending_time = nil
#     @start_on = Date.parse(start_on)
#     @end_on = Date.parse(end_on)
#     @starting_time, @ending_time = starting_time, ending_time
#   end
  
#   def to_s
#     start_on.strftime("#{start_on.day.ordinalize} %B %Y")
#   end
# end


# class Fixnum
#   def ordinalize
#       if (11..13).include?(self.abs % 100)
#         "#{self}th"
#       else
#         case self.to_i.abs % 10
#           when 1; "#{self}st"
#           when 2; "#{self}nd"
#           when 3; "#{self}rd"
#           else    "#{self}th"
#         end
#       end
#     end
# end
