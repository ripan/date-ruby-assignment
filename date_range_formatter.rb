require 'date'
class DateRangeFormatter

  attr_reader :start_on, :end_on, :starting_time, :ending_time

  def initialize start_on, end_on, starting_time = nil, ending_time = nil
    @start_on = Date.parse(start_on)
    @end_on = Date.parse(end_on)
    @starting_time, @ending_time = starting_time, ending_time
  end

  def to_s
    if same_day?
      fm = FormatterDay.new(start_on.to_s,end_on.to_s,starting_time, ending_time)
    elsif same_month?
      fm = FormatterMonth.new(start_on.to_s,end_on.to_s,starting_time, ending_time)
    elsif same_year?
      fm = FormatterYear.new(start_on.to_s,end_on.to_s,starting_time, ending_time)
    elsif different_year?
      fm = FormatterDifferentYear.new(start_on.to_s,end_on.to_s,starting_time, ending_time)
    end
    return fm.to_s
  end

  def same_day?
    start_on == end_on
  end

  def same_month?
    start_on.month == end_on.month
  end

  def same_year?
    start_on.year == end_on.year
  end

  def different_year?
    start_on.year != end_on.year
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
