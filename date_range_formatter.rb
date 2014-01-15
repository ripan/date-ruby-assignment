require 'date'
class DateRangeFormatter

  attr_reader :start_on, :end_on, :starting_time, :ending_time

  def initialize start_on, end_on, starting_time = nil, ending_time = nil
    @start_on = Date.parse(start_on)
    @end_on = Date.parse(end_on)
    @starting_time, @ending_time = starting_time, ending_time
  end

  def to_s
    if start_on.day == end_on.day
      fm = FormatterDay.new(start_on.to_s,end_on.to_s,starting_time, ending_time)
    elsif start_on.month == end_on.month
      fm = FormatterMonth.new(start_on.to_s,end_on.to_s,starting_time, ending_time)
    elsif start_on.year == end_on.year
      fm = FormatterYear.new(start_on.to_s,end_on.to_s,starting_time, ending_time)
    else
      fm = FormatterDifferentYear.new(start_on.to_s,end_on.to_s,starting_time, ending_time)
    end
    return fm.to_s
  end

end


class Fixnum
  def ordinalize
    if (11..13).include?(self.abs % 100)
      "#{self}th"
    else
      case self.to_i.abs % 10
      when 1; "#{self}st"
      when 2; "#{self}nd"
      when 3; "#{self}rd"
      else    "#{self}th"
      end
    end
  end
end

class FormatterDay < DateRangeFormatter

  def initialize start_on, end_on, starting_time = nil, ending_time = nil
    super
  end

  def to_s
    if @starting_time.nil?
      a = @start_on.strftime("#{@start_on.day.ordinalize} %B %Y")
    elsif @ending_time.nil?
      a = @start_on.strftime("#{@start_on.day.ordinalize} %B %Y at #{@starting_time}")
    else
      a =  @start_on.strftime("#{@start_on.day.ordinalize} %B %Y at #{@starting_time} to #{@ending_time}")
    end
    return a
  end

end

class FormatterMonth < DateRangeFormatter

  def initialize start_on, end_on, starting_time = nil, ending_time = nil
    super
  end

  def to_s
    if @starting_time.nil?
      a = @start_on.strftime("#{@start_on.day.ordinalize} - #{@end_on.day.ordinalize} %B %Y")
    elsif @ending_time.nil?
      a = @start_on.strftime("#{@start_on.day.ordinalize} %B %Y at #{@starting_time} - #{@end_on.day.ordinalize} %B %Y")
    else
      a =  @start_on.strftime("#{@start_on.day.ordinalize} %B %Y at #{@starting_time} - #{@end_on.day.ordinalize} %B %Y at #{@ending_time}")
    end
    return a
  end

end

class FormatterYear < DateRangeFormatter

  def initialize start_on, end_on, starting_time = nil, ending_time = nil
    super
  end

  def to_s
    if @starting_time.nil?
      a = @start_on.strftime("#{@start_on.day.ordinalize} %B - #{@end_on.day.ordinalize} #{Date::MONTHNAMES[@end_on.month]} %Y")
    elsif @ending_time.nil?
      a = @start_on.strftime("#{@start_on.day.ordinalize} %B %Y at #{@starting_time} - #{@end_on.day.ordinalize} #{Date::MONTHNAMES[@end_on.month]} %Y")
    else
      a =  @start_on.strftime("#{@start_on.day.ordinalize} %B %Y at #{@starting_time} - #{@end_on.day.ordinalize} #{Date::MONTHNAMES[@end_on.month]} %Y at #{@ending_time}")
    end
    return a
  end

end


class FormatterDifferentYear < DateRangeFormatter

  def initialize start_on, end_on, starting_time = nil, ending_time = nil
    super
  end

  def to_s
    if @starting_time.nil?
      a = @start_on.strftime("#{@start_on.day.ordinalize} %B %Y - #{@end_on.day.ordinalize} #{Date::MONTHNAMES[@end_on.month]} #{@end_on.year}")
    elsif @ending_time.nil?
      a = @start_on.strftime("#{@start_on.day.ordinalize} %B %Y at #{@starting_time} - #{@end_on.day.ordinalize} #{Date::MONTHNAMES[@end_on.month]} #{@end_on.year}")
    else
      a =  @start_on.strftime("#{@start_on.day.ordinalize} %B %Y at #{@starting_time} - #{@end_on.day.ordinalize} #{Date::MONTHNAMES[@end_on.month]} #{@end_on.year} at #{@ending_time}")
    end
    return a
  end
  
end

# formatter = FormatterDay.new "2009-11-1", "2009-11-1"
# puts formatter.to_s

puts 'SAME DAY'
formatter = DateRangeFormatter.new "2009-11-1", "2009-11-1"
puts formatter.to_s
puts formatter.to_s == "1st November 2009"

formatter = DateRangeFormatter.new "2009-11-1", "2009-11-1", "10:00"
puts formatter.to_s
puts formatter.to_s == "1st November 2009 at 10:00"

formatter = DateRangeFormatter.new "2009-11-1", "2009-11-1", "10:00", "11:00"
puts formatter.to_s
puts formatter.to_s == "1st November 2009 at 10:00 to 11:00"

puts 'SAME MONTH'

formatter = DateRangeFormatter.new "2009-11-1", "2009-11-3"
puts formatter.to_s
puts formatter.to_s == "1st - 3rd November 2009"

formatter = DateRangeFormatter.new "2009-11-1", "2009-11-3", "10:00"
puts formatter.to_s
puts formatter.to_s == "1st November 2009 at 10:00 - 3rd November 2009"

formatter = DateRangeFormatter.new "2009-11-1", "2009-11-3", "10:00", "11:00"
puts formatter.to_s
puts formatter.to_s == "1st November 2009 at 10:00 - 3rd November 2009 at 11:00"

puts 'SAME YEAR'

formatter = DateRangeFormatter.new "2009-11-1", "2009-12-1"
puts formatter.to_s
puts formatter.to_s == "1st November - 1st December 2009"

formatter = DateRangeFormatter.new "2009-11-1", "2009-12-1", "10:00"
puts formatter.to_s
puts formatter.to_s == "1st November 2009 at 10:00 - 1st December 2009"

formatter = DateRangeFormatter.new "2009-11-1", "2009-12-1", "10:00", "11:00"
puts formatter.to_s
puts formatter.to_s == "1st November 2009 at 10:00 - 1st December 2009 at 11:00"


puts 'DIFFERENT YEAR'


formatter = DateRangeFormatter.new "2009-11-1", "2010-12-1"
puts formatter.to_s
puts formatter.to_s == "1st November 2009 - 1st December 2010"

formatter = DateRangeFormatter.new "2009-11-1", "2010-12-1", "10:00"
puts formatter.to_s
puts formatter.to_s == "1st November 2009 at 10:00 - 1st December 2010"

formatter = DateRangeFormatter.new "2009-11-1", "2010-12-1", "10:00", "11:00"
puts formatter.to_s
puts formatter.to_s == "1st November 2009 at 10:00 - 1st December 2010 at 11:00"