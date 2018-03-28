#coding: utf-8

require_relative 'tio'

tio = Tio.new

puts 'Позвонить Маше в 9:35'
tio.parse('Позвонить Маше в 9:35')

puts tio.date, tio.event_text, '---------------'

puts 'Call John at 20:05'
tio.parse('Call John at 20:05')

puts tio.date, tio.event_text, '---------------'

puts 'Meeting at Monday'
tio.parse('Meeting at Monday')

puts tio.date, tio.event_text