#!/usr/bin/env ruby
require 'open-uri'

username = ARGV[0].to_s
interval = 5
ENDPOINT = 'http://mystatus.skype.com/' + username + '.num?cachebuster='

dictionary = [
	'unknown',
	'offline',
	'online',
	'away',
	'not availible',
	'do not disturb',
	'invisible',
	'skype me'
]

def status_code()
	return URI.parse( ENDPOINT + rand().to_s ).read.to_i
end

# retrieve status code
base_status = status_code


# print the banner
puts "\n" + "="*7 + " Skype Stalker " + "="*7
puts "\"#{username}\" is currently #{dictionary[base_status]}. Now just relax and get on with your fascinating life. I'll let you know as soon as the status changes.\n\n"

while(true):
	status = status_code
	if status != base_status:
		puts "Hey you! \"#{username}\" just changed status to: " + dictionary[status]
		system('tput bel')
		break
	end
	sleep(interval)
end