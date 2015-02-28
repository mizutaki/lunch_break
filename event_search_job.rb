# coding: utf-8
$LOAD_PATH << File.dirname(__FILE__)
require 'open-uri'
require 'json'
require 'yaml'
require 'date'
require 'db_manager'
require 'mail_sender'

class EventSearchJob
  attr_accessor :url

  def initialize
    @url = get_url
  end

  def call
    html = open(@url).read
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
          mail = MailSender.new(arr)
          mail.send
        end
      end 
    end
  end

  private
    def get_url
      config = YAML.load_file("config.yml")
      url = config["connpass_url"] +"?"+ config["connpass_option_keyword"] +"&"+ config["connpass_option_order"] + "&" +config["connpass_option_ymd"]
      dates = get_dates(1)
      dates.each do |date|
        url << date + ','
      end
      return url
    end

    #現在日時〜manth分の年月日を配列で取得する
    def get_dates(month)
      current_date = Date.today
      after_date = current_date >> month
      dates = []
      Date.parse(current_date.to_s).upto(Date.parse(after_date.to_s)){|i| dates << i.strftime("%Y%m%d")}
      return dates
    end
end
