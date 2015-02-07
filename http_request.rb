# coding: utf-8
require 'open-uri'
require 'pp'
require 'json'
require_relative 'dbmanager'

class Event
  attr_accessor :url, :title, :description
end

#connpassAPIをたたくHTTPクライアント
html = open('http://connpass.com/api/v1/event/?keyword=python&count=2').read
json = JSON.parser.new(html)
hash = json.parse()
db = DBManager.new
puts db.class
arr = []
h = {}
hash.each do |key, value|
  if key == "events" then
    
    value.each do |arr|
      event = Event.new
      event.url = arr["event_url"]
      event.title = arr["title"]
      event.description = arr["description"]
      db.transaction
      db.insert_table(event.url, event.title, event.description)
      db.commit
    end
  end 
end