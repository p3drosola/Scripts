#!/usr/bin/env ruby

require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'htmlentities'

# config
site = 'http://www.goodreads.com/author/quotes/2546.Chuck_Palahniuk?page='
pages = 14

# code
site = site+(1+rand(pages)).to_s
doc = Hpricot(open( site ))
quotes = (doc/'.quotes .quoteText')

def br2nl(s)
     s.gsub(/< *?br *?\/ *?>/, "\n")
end

selected_quote = quotes.sort_by{ rand }[0]
quote_text = br2nl(( selected_quote.inner_html.split("<br /> &#8213;") )[0])
from = (selected_quote/"a[@href*='/work/']").inner_html

coder = HTMLEntities.new
quote_text = coder.decode(quote_text)


puts quote_text
puts '* '+from if from != ''