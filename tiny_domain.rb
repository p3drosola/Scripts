require 'rubygems'
require 'json'
require 'open-uri'
#require 'net/http'

length = 4
debug = true
a = %w"a b c d e f g h i j k l m n o p q r s t u v w x y z 1 2 3 4 5 6 7 8 9 0"

def APIRequest ( word )
  url = "http://domai.nr/api/json/search?q=#{word}"  
	resp = URI.parse( url ).read
  data = JSON.parse( resp )
  if data.has_key? 'Error'
    raise "Domai.nr service error"
  end
  dot_com_status = data['results'][0]['availability']
  return dot_com_status
end

combinations = a.length**length
(0..combinations-1).each do |perm_number| # loop through combinations
  domain = ''
  (1..length).each do |char_number| # loop through characters
    char_reference = (perm_number / a.length ** (char_number-1)).floor % a.length
    character = a[char_reference]
    domain << character
  end
  
  print "checking #{domain}.com ... " unless !debug
  status = APIRequest(domain)
  if status == 'available'
    print "\n==> #{domain}.com is availible!\n"
  else
    print "taken\n" unless !debug
  end
end