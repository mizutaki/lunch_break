# coding: utf-8
require 'open-uri'
require 'pp'
require 'json'
require 'yaml'
require_relative 'dbmanager'

config = YAML.load_file("config.yml")
puts config
url = config["url"] + config["option"]
class Event
  attr_accessor :url, :title, :description
end

html = open(url).read
json = JSON.parser.new(html)
hash = json.parse()
db = DBManager.new
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
