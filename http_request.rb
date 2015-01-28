#! ruby -EUTF-8
# coding: utf-8
require 'net/http'
require 'uri'
require 'pp'

#connpassAPIをたたくHTTPクライアント

url = URI.parse('http://connpass.com/api/v1/event/?keyword=python ')
content = Net::HTTP.get(url)
c = content.split(',')
File.open("test.txt", "w") do |f|
	f.puts c
end