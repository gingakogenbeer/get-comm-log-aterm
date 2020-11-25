#!/usr/bin/env ruby
#-*- coding: utf-8 -*-

require "open-uri"
require "nokogiri"
require "mechanize"

##--- login user / password
user, pass = "***", "***"

##--- login URL
loginUrl = "http://***"
##--- scraping target URL
tgtUrl = "http://***/index.cgi/log_main"

##--- Basic Authentication
agent = Mechanize.new
agent.user_agent = "***"
agent.add_auth(loginUrl, user, pass) 

charset = 'UTF-8'
html = agent.get(tgtUrl).content.toutf8
doc = Nokogiri::HTML.parse(html, nil, charset)
body = doc.at_css("body")
body.search("script").each(&:remove)

##--- modify below as needed.
log = body.xpath('//div[@class="log_area"]/pre/text()').to_s.split("\n")
puts log.select{ |a|
    a =~ /MAC address, IP address etc /
}