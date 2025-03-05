require 'csv'
require 'time'

# Read the CSV file
contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

def wday_to_weekdays(week_days)
    case week_days
    when 0
      "Sunday"
    when 1
      "Monday"
    when 2
      "Tuesday"
    when 3
      "Wednesday"
    when 4
      "Thursday"
    when 5
      "Friday"
    when 6
      "Saturday"
    else
      "Invalid day"
    end
  end

  weekday_count = Hash.new(0)

  contents.each do |row|
    reg_date = row[:regdate]
    time = Time.strptime(reg_date, "%m/%d/%y %H:%M")
    week_days = time.wday 
    weekday_name = wday_to_weekdays(week_days) 
    weekday_count[weekday_name] += 1
    end

sorted_days = weekday_count.sort_by { |weekday, count| -count }

puts "Peak registration days:"
sorted_days.each do |weekday, count|
  puts "#{weekday} - #{count} registrations"
end

