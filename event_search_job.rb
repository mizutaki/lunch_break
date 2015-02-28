# coding: utf-8
$LOAD_PATH << File.dirname(__FILE__)
require 'open-uri'
require 'json'
require 'yaml'
require 'db_manager'
require 'mail_sender'
require 'url_creator'

class EventSearchJob
  attr_accessor :url

  def initialize
    @url = URLCreator.build_url(YAML.load_file('config.yml'))
  end

  def call
    db = DBManager.new
    @url.each do |url|
      html = open(url).read
      hash = JSON.parser.new(html).parse
      hash["events"].each do |events|
        events = events["event"] if events.key?("event") #ATND対応
        next if db.record?(events["event_url"])
        db.transaction
        db.insert_table(events["event_url"], events["title"], events["description"])
        db.commit
        mail = MailSender.new(events)
        mail.send
      end
    end
  end
end