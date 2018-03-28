#  Created by Sergey Lenkov on 11.01.12.
#  Copyright (c) 2012 Sergey Lenkov. All rights reserved.

require 'yaml'
require 'date'

class Tio
  attr_accessor :event_text, :original_text, :date
  
  def initialize()
    @yaml = YAML.load_file('tokens.yaml')
  end
  
  def parse(text)
    @original_text = text
    @event_text = text
    
    reset

    @yaml.each_pair do |key, value|
      if key == 'time'
        value.each do |item|
          parse_time(item)
        end
      end
      
      if key == 'date'
        value.each do |item|
          parse_date(item)
        end
      end
      
      if key == 'weekday'
        value.each do |item|
          parse_weekday(item)
        end
      end
      
      if key == 'future'
        value.each do |item|
          parse_future(item)
        end
      end
      
      if key == 'past'
        value.each do |item|
          parse_past(item)
        end
      end
      
      if key == 'hours'
        value.each do |item|
          parse_hours(item)
        end
      end
      
      if key == 'minutes'
        value.each do |item|
          parse_minutes(item)
        end
      end
      
      if key == 'years'
        value.each do |item|
          parse_years(item)
        end
      end
      
      if key == 'months'
        value.each do |item|
          parse_months(item)
        end
      end
      
      if key == 'weeks'
        value.each do |item|
          parse_weeks(item)
        end
      end
      
      if key == 'days'
        value.each do |item|
          parse_days(item)
        end
      end
      
      if key == 'day-parts'
        value.each do |item|
          parse_day_parts(item)
        end
      end
    end
    
    normalize_event_text()
    create_date()
  end
  
  def reset
    @year = 0
    @month = 0
    @day = 0
    @hour = 0
    @minute = 0
    @second = 0
    @weekday = 0;
    @future_offset = 0
    @past_offset = 0
    @hours_offset = 0
    @minutes_offset = 0
    @days_offset = 0
    @weeks_offset = 0
    @months_offset = 0
    @years_offset = 0
    @morning_hour = 8
    @afternoon_hour = 12
    @evening_hour = 18
    @night_hour = 21
  end
  
  def parse_time(item)
    regexp = Regexp.new(item['regexp'])
    hour_group = item['hour'].to_i
    minute_group = item['minute'].to_i
    second_group = item['second'].to_i
    modifier = item['modifier'].to_i
    
    if regexp.match(@event_text)
      if hour_group > 0
        @hour = regexp.match(@event_text)[hour_group].to_i
      end
      
      if minute_group > 0
        @minute = regexp.match(@event_text)[minute_group].to_i
      end
      
      if second_group > 0
        @second = regexp.match(@event_text)[second_group].to_i
      end
      
      if modifier > 0
        @hour = @hour + modifier
      end
      
      clear_event_text(regexp)
    end
  end
  
  def parse_date(item)
    regexp = Regexp.new(item['regexp'])
    year_group = item['year'].to_i
    month_group = item['month'].to_i
    day_group = item['day'].to_i
    
    if regexp.match(@event_text)
      if year_group > 0
        @year = regexp.match(@event_text)[year_group].to_i
      end
      
      if month_group > 0
        @month = month_from_str(regexp.match(@event_text)[month_group])
      end
      
      if day_group > 0
        @day = regexp.match(@event_text)[day_group].to_i
      end
      
      clear_event_text(regexp)
    end
  end
  
  def parse_weekday(item)
    regexp = Regexp.new(item['regexp'])
    day_group = item['day'].to_i
    
    if regexp.match(@event_text)
      if day_group > 0
        @weekday = weekday_from_str(regexp.match(@event_text)[day_group])
      end
      
      clear_event_text(regexp)
    end
  end
  
  def parse_future(item)
    regexp = Regexp.new(item['regexp'], true)
    offset = item['offset'].to_i

    if regexp.match(@event_text)      
      if offset > 0
        @future_offset = offset
      end

      clear_event_text(regexp)
    end
  end
  
  def parse_past(item)
    regexp = Regexp.new(item['regexp'])
    offset = item['offset'].to_i
    
    if regexp.match(@event_text)
      if offset > 0
        @past_offset = offset
      end
      
      clear_event_text(regexp)
    end
  end
  
  def parse_hours(item)
    regexp = Regexp.new(item['regexp'])
    count_group = item['count'].to_i

    if regexp.match(@event_text)      
      if count_group > 0
        @hours_offset = regexp.match(@event_text)[count_group].to_i
      end

      clear_event_text(regexp)
    end
  end
  
  def parse_minutes(item)
    regexp = Regexp.new(item['regexp'])
    count_group = item['count'].to_i
    
    if regexp.match(@event_text)
      if count_group > 0
        @minutes_offset = regexp.match(@event_text)[count_group].to_i
      end
      
      clear_event_text(regexp)
    end
  end
  
  def parse_years(item)
    regexp = Regexp.new(item['regexp'])
    count_group = item['count'].to_i
    
    if regexp.match(@event_text)
      if count_group > 0
        @years_offset = regexp.match(@event_text)[count_group].to_i
      end
      
      clear_event_text(regexp)
    end
  end
  
  def parse_months(item)
    regexp = Regexp.new(item['regexp'])
    count_group = item['count'].to_i
    
    if regexp.match(@event_text)
      if count_group > 0
        @months_offset = regexp.match(@event_text)[count_group].to_i
      end
      
      clear_event_text(regexp)
    end
  end
  
  def parse_weeks(item)
    regexp = Regexp.new(item['regexp'])
    count_group = item['count'].to_i
    
    if regexp.match(@event_text)
      if count_group > 0
        @weeks_offset = regexp.match(@event_text)[count_group].to_i
      end
      
      clear_event_text(regexp)
    end
  end
  
  def parse_days(item)
    regexp = Regexp.new(item['regexp'])
    count_group = item['count'].to_i
    
    if regexp.match(@event_text)
      if count_group > 0
        @days_offset = regexp.match(@event_text)[count_group].to_i
      end
      
      clear_event_text(regexp)
    end
  end
  
  def parse_day_parts(item)
    regexp = Regexp.new(item['regexp'])
    type = item['type'];

    if regexp.match(@event_text)
      if type == 0
        @hour = @morning_hour
      end

      if type == 1
        @hour = @afternoon_hour
      end
      
      if type == 2
        @hour = @evening_hour
      end
      
      if type == 3
        @hour = @night_hour
      end

      clear_event_text(regexp)
    end
  end
  
  def month_from_str(text)
    number = 0
    
    text.strip!
    text.downcase!

    if /[0-12]/.match(text)
      number = text.to_i
    else
      @yaml['month-names'].each do |month|
        month.each do |key, value|
          if Regexp.new(value).match(text)
            number = key.to_i
            break
          end
        end
      end
    end
    
    return number
  end
  
  def weekday_from_str(text)
    number = 0
    
    text.strip!
    text.downcase!

    @yaml['weekday-names'].each do |weekday|
      weekday.each do |key, value|
        if Regexp.new(value).match(text)
          number = key.to_i
          break
        end
      end
    end
    
    return number
  end
  
  def create_date
    if @year == 0
      @year = Date.today.year
    end
    
    if @month == 0
      @month = Date.today.month
    end
    
    if @day == 0
      @day = Date.today.mday
    end
    
    if @weekday > 0
      current_weekday = Date.today.wday + 1
      delta = @weekday - current_weekday
      date = Date.today + delta
      
      if delta < 0
        date = Date.today + (delta + 7)
      end
      
      @year = date.year
      @month = date.month
      @day = date.mday
    end

    if @future_offset > 0
      date = Date.today + @future_offset

      @year = date.year
      @month = date.month
      @day = date.mday
    end

    if @past_offset > 0
      date = Date.today - @past_offset

      @year = date.year
      @month = date.month
      @day = date.mday
    end

    if @hours_offset > 0
      time = Time.now + (@hours_offset * 60 * 60)

      @year = time.year
      @month = time.month
      @day = time.mday
      @hour = time.hour
      @minute = time.min
    end

    if @minutes_offset > 0
      time = Time.now + (@minutes_offset * 60)

      @year = time.year
      @month = time.month
      @day = time.mday
      @hour = time.hour
      @minute = time.min
    end

    if @days_offset > 0
      date = Date.today + @days_offset

      @year = date.year
      @month = date.month
      @day = date.mday
    end

    if @weeks_offset > 0
      date = Date.today + (@weeks_offset * 7)

      @year = date.year
      @month = date.month 
      @day = date.mday
    end

    if @months_offset > 0
      date = Date.today >> @months_offset

      @year = date.year
      @month = date.month 
      @day = date.mday
    end

    if @years_offset > 0
      date = Date.today >> (@years_offset * 12)

      @year = date.year
      @month = date.month 
      @day = date.mday
    end

    @date = DateTime.new(@year, @month, @day, @hour, @minute, @second)
  end
  
  def clear_event_text(regexp)
    @event_text.sub!(regexp, '')
  end
  
  def normalize_event_text
    @event_text.squeeze!(' ')
    @event_text.gsub!(/^,/, '')
    @event_text.gsub!(/^\./, '')
    @event_text.strip!
  end
  
  def event_text
    @event_text
  end
  
  def original_text
    @original_text
  end
  
  def date
    @date
  end
end