require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'


def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def clean_zip_code(zip_code)
  zip_code.to_s.rjust(5, '0')[0..4]
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def clean_phone_number phone
  final_phone = phone.split('').reduce('') do |result, char|
    if char >= '0' && char <= '9'
      result += char
    end
    result
  end
  
  if final_phone.length < 10 || final_phone.length > 11
    final_phone = '00_00_000_000'
  elsif final_phone.length == 11 && final_phone[0] == '1'
    final_phone = final_phone[1..]
  end
  final_phone
end

puts 'Event Manager Initialized!'

template_letter = File.read 'form_letter.erb'
erb_template = ERB.new template_letter

hour_hash = Hash.new(0)

day_names = Date::DAYNAMES
day_hash = Hash.new(0)

contents = CSV.open 'event_attendees.csv', headers: true, header_converters: :symbol
puts contents
contents.each do |row|
  id = row[0]

  name = row[:first_name]

  zip_code = clean_zip_code(row[:zipcode])
  legislators = legislators_by_zipcode zip_code

  form_letter = erb_template.result binding
  save_thank_you_letter(id, form_letter)

  clean_phone_number row[:homephone]
  
  reg_time = Time.strptime row[:regdate], '%m/%d/%Y %k:%M'
  reg_hour = reg_time.strftime '%k'
  reg_week_day = reg_time.wday
  hour_hash[reg_hour] += 1
  day_hash[day_names[reg_week_day]] += 1
end

frequent_hours = hour_hash.keys.sort_by { |key| -hour_hash[key] }
puts "Frequently registered hours ::: #{frequent_hours}"

frequent_days = day_hash.keys.sort_by { |key| -day_hash[key] }
puts "Frequently registered days ::: #{frequent_days}"
