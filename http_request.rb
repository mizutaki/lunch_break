# coding: utf-8
require 'open-uri'
require 'pp'
require 'json'

#connpassAPIをたたくHTTPクライアント
html = open('http://connpass.com/api/v1/event/?keyword=python').read
json = JSON.parser.new(html)
hash = json.parse()
pp hash
#イベント毎に分割して、それぞれ処理していく
File.open("test.txt", "w") do |f|
	f.puts 
	f.puts hash
	f.puts 
end