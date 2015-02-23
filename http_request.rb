# coding: utf-8
require 'open-uri'
require 'pp'
require 'json'
require 'yaml'
require 'date'
require_relative 'db_manager'

class HTTPRequest
  def call
    config = YAML.load_file("config.yml")
    current_date = Date.today
    after_date = current_date >> 1
    dates = []
    Date.parse(current_date.to_s).upto(Date.parse(after_date.to_s)){|i| dates << i.strftime("%Y%m%d")}
    url = config["url"] + config["option"] + "&ymd="
    dates.each do |date|
      url << date + ','
    end
    html = open(url).read
    json = JSON.parser.new(html)
    hash = json.parse()
    db = DBManager.new
    hash.each do |key, value|
      if key == "events" then
        value.each do |arr|
          next if db.record?(arr["event_url"])
          db.transaction
          db.insert_table(arr["event_url"], arr["title"], arr["description"])
          db.commit
        end
      end 
    end
  end
end