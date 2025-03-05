require 'csv'

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

def clean_home_phone(home_phone)
    home_phone.gsub!(/[[:punct:]]/, '')
    home_phone.gsub!(" ", "")
    home_phone.gsub!(/[^\d]/, '')
    home_phone
end

def find_valid_numbers(home_phone)
    clean_numbers = clean_home_phone(home_phone)
    if clean_numbers.length == 11 && clean_numbers[0] == '1'
        clean_numbers[1..-1]
    end

    if clean_numbers.length == 10
        clean_numbers
    else "Invalid Number"
    end
end


valid_entries = []

contents.each do |row|
  name = row[:first_name]
  home_phone = row[:homephone]

  home_phone = find_valid_numbers(home_phone)
    
  if home_phone != "Invalid Number"
    valid_entries << { name: name, phone_number: home_phone }
  end

  puts "#{name} #{home_phone}"
end

def send_alert(name, phone_number)
    puts "Sending alert to #{name} at #{phone_number}..."
end

valid_entries.each do |entry|
    name = entry[:name]
    phone_number = entry[:phone_number]
    send_alert(name, phone_number)
  end
