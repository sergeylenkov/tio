#  Created by Sergey Lenkov on 11.01.12.
#  Copyright (c) 2012 Sergey Lenkov. All rights reserved.

#coding: utf-8

require 'test/unit'
require_relative 'tio'

class TioTest < Test::Unit::TestCase
    def test_1
      tio = Tio.new
      tio.parse('23:40   Футбол. Чемпионат Англии.')
        
      assert_equal(tio.date.hour, 23, 'Hour')
      assert_equal(tio.date.min, 40, 'Minute')
      assert_equal(tio.event_text, 'Футбол. Чемпионат Англии.', 'Event text')
    end
    
    def test_2
      tio = Tio.new
      tio.parse('Позвонить Маше в 9:35')
      
      assert_equal(tio.date.hour, 9, 'Hour')
      assert_equal(tio.date.min, 35, 'Minute')
      assert_equal(tio.event_text, 'Позвонить Маше', 'Event text')
    end
    
    def test_3
      tio = Tio.new
      tio.parse('Call John at 20:05')

      assert_equal(tio.date.hour, 20, 'Hour')
      assert_equal(tio.date.min, 5, 'Minute')
      assert_equal(tio.event_text, 'Call John', 'Event text')
    end
    
    def test_4
      tio = Tio.new
      tio.parse('21:00 TV Show')
      
      assert_equal(tio.date.hour, 21, 'Hour')
      assert_equal(tio.date.min, 0, 'Minute')
      assert_equal(tio.event_text, 'TV Show', 'Event text')
    end
    
    def test_5
      tio = Tio.new
      tio.parse('Важная встреча 5 января')
      
      assert_equal(tio.date.month, 1, 'event month')
      assert_equal(tio.date.mday, 5, 'event day')
      assert_equal(tio.event_text, 'Важная встреча', 'Event text')
    end
    
    def test_6
      tio = Tio.new
      tio.parse('1 июля 2012 финал Евро-2012')

      assert_equal(tio.date.year, 2012, 'Year')
      assert_equal(tio.date.month, 7, 'Month')
      assert_equal(tio.date.mday, 1, 'Day')
      assert_equal(tio.event_text, 'финал Евро-2012', 'Event text')
    end
    
    def test_7
      tio = Tio.new
      tio.parse('Cool party 29 september')

      assert_equal(tio.date.month, 9, 'Month')
      assert_equal(tio.date.mday, 29, 'Day')
      assert_equal(tio.event_text, 'Cool party', 'Event text')
    end

    def test_8
      tio = Tio.new
      tio.parse('February 9, National Conference')

      assert_equal(tio.date.month, 2, 'Month')
      assert_equal(tio.date.mday, 9, 'Day')
      assert_equal(tio.event_text, 'National Conference', 'Event text')
    end    

    def test_9
      tio = Tio.new
      tio.parse('Some event Jan 12th 2012')

      assert_equal(tio.date.year, 2012, 'Year')
      assert_equal(tio.date.month, 1, 'Month')
      assert_equal(tio.date.mday, 12, 'Day')
      assert_equal(tio.event_text, 'Some event', 'Event text')
    end

    def test_10
      tio = Tio.new
      tio.parse('Событие 20-го марта 2012')

      assert_equal(tio.date.year, 2012, 'Year')
      assert_equal(tio.date.month, 3, 'Month')
      assert_equal(tio.date.mday, 20, 'Day')
      assert_equal(tio.event_text, 'Событие', 'Event text')
    end   

    def test_11
      tio = Tio.new
      tio.parse('В пятницу прием у зубного врача')

      assert_equal(tio.date.wday, 5, 'Weekday')
      assert_equal(tio.event_text, 'прием у зубного врача', 'Event text')
    end   

    def test_12
      tio = Tio.new
      tio.parse('Meeting at Monday')

      assert_equal(tio.date.wday, 1, 'Weekday')
      assert_equal(tio.event_text, 'Meeting', 'Event text')
    end

    def test_13
      date = Date.today + 1

      tio = Tio.new
      tio.parse('Завтра собрание')

      assert_equal(tio.date.year, date.year, 'Year')
      assert_equal(tio.date.month, date.month, 'Month')
      assert_equal(tio.date.mday, date.mday, 'Day')
      assert_equal(tio.event_text, 'собрание', 'Event text')
    end

    def test_14
      date = Date.today + 1
      
      tio = Tio.new
      tio.parse('Some event tomorrow')

      assert_equal(tio.date.year, date.year, 'Year')
      assert_equal(tio.date.month, date.month, 'Month')
      assert_equal(tio.date.mday, date.mday, 'Day')
      assert_equal(tio.event_text, 'Some event', 'Event text')
    end
    
    def test_15
      date = Date.today + 2
      
      tio = Tio.new
      tio.parse('Послезавтра сдать отчет')

      assert_equal(tio.date.year, date.year, 'Year')
      assert_equal(tio.date.month, date.month, 'Month')
      assert_equal(tio.date.mday, date.mday, 'Day')
      assert_equal(tio.event_text, 'сдать отчет', 'Event text')
    end
    
    def test_16
      date = Date.today - 1
      
      tio = Tio.new
      tio.parse('Вчера был дедлайн')

      assert_equal(tio.date.year, date.year, 'Year')
      assert_equal(tio.date.month, date.month, 'Month')
      assert_equal(tio.date.mday, date.mday, 'Day')
      assert_equal(tio.event_text, 'был дедлайн', 'Event text')
    end
    
    def test_17
      date = Date.today + 3
      
      tio = Tio.new
      tio.parse('Встреча через 3 дня')

      assert_equal(tio.date.year, date.year, 'Year')
      assert_equal(tio.date.month, date.month, 'Month')
      assert_equal(tio.date.mday, date.mday, 'Day')
      assert_equal(tio.event_text, 'Встреча', 'Event text')
    end
    
    def test_18
      date = Date.today + 4
      
      tio = Tio.new
      tio.parse('Travel in 4 days')

      assert_equal(tio.date.year, date.year, 'Year')
      assert_equal(tio.date.month, date.month, 'Month')
      assert_equal(tio.date.mday, date.mday, 'Day')

      assert_equal(tio.event_text, 'Travel', 'Event text')
    end
    
    def test_19
      date = Date.today + 14
      
      tio = Tio.new
      tio.parse('Зайти к Маше через 2 недели')

      assert_equal(tio.date.year, date.year, 'Year')
      assert_equal(tio.date.month, date.month, 'Month')
      assert_equal(tio.date.mday, date.mday, 'Day')
      assert_equal(tio.event_text, 'Зайти к Маше', 'Event text')
    end
    
    def test_20 
      date = Date.today >> 3
      
      tio = Tio.new
      tio.parse('Vacation in 3 months')

      assert_equal(tio.date.year, date.year, 'Year')
      assert_equal(tio.date.month, date.month, 'Month')
      assert_equal(tio.event_text, 'Vacation', 'Event text')
    end
    
    def test_21
      date = Time.now + (3 * 60 * 60)

      tio = Tio.new
      tio.parse('Позвонить через 3 часа')

      assert_equal(tio.date.hour, date.hour, 'Hour')
      assert_equal(tio.date.min, date.min, 'Minute')
      assert_equal(tio.event_text, 'Позвонить', 'Event text')
    end
    
    def test_22
      tio = Tio.new
      tio.parse('14.01.2012. Выставка')

      assert_equal(tio.date.year, 2012, 'Year')
      assert_equal(tio.date.month, 1, 'Month')
      assert_equal(tio.date.mday, 14, 'Day')
      assert_equal(tio.event_text, 'Выставка', 'Event text')
    end
    
    def test_23
      tio = Tio.new
      tio.parse('28/12/2012. Выставка')

      assert_equal(tio.date.year, 2012, 'Year')
      assert_equal(tio.date.month, 12, 'Month')
      assert_equal(tio.date.mday, 28, 'Day')
      assert_equal(tio.event_text, 'Выставка', 'Event text')
    end
    
    def test_24
      tio = Tio.new
      tio.parse('08-11-2010. Event')

      assert_equal(tio.date.year, 2010, 'Year')
      assert_equal(tio.date.month, 11, 'Month')
      assert_equal(tio.date.mday, 8, 'Day')
      assert_equal(tio.event_text, 'Event', 'Event text')
    end
    
    def test_25
      tio = Tio.new
      tio.parse('01-Nov-2011. Event')

      assert_equal(tio.date.year, 2011, 'Year')
      assert_equal(tio.date.month, 11, 'Month')
      assert_equal(tio.date.mday, 1, 'Day')
      assert_equal(tio.event_text, 'Event', 'Event text')
    end
    
    def test_26
      tio = Tio.new
      tio.parse('Event 9 June, 2011 at 13:30')

      assert_equal(tio.date.year, 2011, 'Year')
      assert_equal(tio.date.month, 6, 'Month')
      assert_equal(tio.date.mday, 9, 'Day')
      assert_equal(tio.date.hour, 13, 'Hour')
      assert_equal(tio.date.min, 30, 'Minute')
      assert_equal(tio.event_text, 'Event', 'Event text')
    end
    
    def test_27
      date = Time.now
      
      tio = Tio.new
      tio.parse('Праздник 8 марта в 15:00')

      assert_equal(tio.date.year, date.year, 'Year')
      assert_equal(tio.date.month, 3, 'Month')
      assert_equal(tio.date.mday, 8, 'Day')
      assert_equal(tio.date.hour, 15, 'Hour')
      assert_equal(tio.date.min, 0, 'Minute')
      assert_equal(tio.event_text, 'Праздник', 'Event text')
    end
    
    def test_28
      tio = Tio.new
      tio.parse('Перезвонить Маше в 14 часов')

      assert_equal(tio.date.hour, 14, 'Hour')
      assert_equal(tio.date.min, 0, 'Minute')
      assert_equal(tio.event_text, 'Перезвонить Маше', 'Event text')
    end
    
    def test_29
      tio = Tio.new
      tio.parse('Перезвонить Маше в 3 часа дня')

      assert_equal(tio.date.hour, 15, 'Hour')
      assert_equal(tio.date.min, 0, 'Minute')
      assert_equal(tio.event_text, 'Перезвонить Маше', 'Event text')
    end
    
    def test_30
      tio = Tio.new
      tio.parse('Event at 2:35 PM')

      assert_equal(tio.date.hour, 14, 'Hour')
      assert_equal(tio.date.min, 35, 'Minute')
      assert_equal(tio.event_text, 'Event', 'Event text')
    end
    
    def test_31
      tio = Tio.new
      tio.parse('С утра перезвонить босу')

      assert_equal(tio.date.hour, 8, 'Hour')
      assert_equal(tio.date.min, 0, 'Minute')
      assert_equal(tio.event_text, 'перезвонить босу', 'Event text')
    end
    
    def test_32
      tio = Tio.new
      tio.parse('Dance party this evening')

      assert_equal(tio.date.hour, 18, 'Hour')
      assert_equal(tio.date.min, 0, 'Minute')
      assert_equal(tio.event_text, 'Dance party', 'Event text')
    end
    
    def test_33
      date = Date.today + 1
      
      tio = Tio.new
      tio.parse('Завтра вечером сходить за покупками')

      assert_equal(tio.date.year, date.year, 'Year')
      assert_equal(tio.date.month, date.month, 'Month')
      assert_equal(tio.date.mday, date.mday, 'Day')
      assert_equal(tio.date.hour, 18, 'Hour')
      assert_equal(tio.date.min, 0, 'Minute')
      assert_equal(tio.event_text, 'сходить за покупками', 'Event text')
    end
end