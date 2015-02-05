# coding: utf-8
require 'open-uri'
require 'pp'
require 'json'

class Event
  attr_accessor :url, :title, :description
end
#connpassAPIをたたくHTTPクライアント
html = open('http://connpass.com/api/v1/event/?keyword=python&count=2').read
json = JSON.parser.new(html)
hash = json.parse()

arr = []
h = {}
hash.each do |key, value|
  if key == "events" then
    value.each do |arr|
      event = Event.new
      event.url = arr["event_url"]
      event.title = arr["title"]
      event.description = arr["description"]
      puts event
    end
  end 
end