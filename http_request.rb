# coding: utf-8
require 'open-uri'
require 'pp'
require 'json'

#connpassAPI��������HTTP�N���C�A���g
html = open('http://connpass.com/api/v1/event/?keyword=python').read
json = JSON.parser.new(html)
hash = json.parse()
pp hash
#�C�x���g���ɕ������āA���ꂼ�ꏈ�����Ă���
File.open("test.txt", "w") do |f|
	f.puts 
	f.puts hash
	f.puts 
end