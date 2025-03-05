# Advertising should be programmed for certain hours based on peak Registration

require 'csv'
require 'time'

# Read the CSV file
contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

# Hash to count occurrences of each hour - ruby hashes start automatically at 0
hour_counts = Hash.new(0)

contents.each do |row|
  reg_date = row[:regdate]

  # create a time object
  time = Time.strptime(reg_date, "%m/%d/%y %H:%M")

  # Extract a block of 1 hour and count it
  hour_counts[time.hour] += 1
end

sorted_hours = hour_counts.sort_by { |hour, count| -count }

puts "Peak registration hours:"
sorted_hours.each do |hour, count|
  puts "#{hour}:00 - #{hour + 1}:00 - #{count} registrations"
end