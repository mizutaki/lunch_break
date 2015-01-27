require 'net/http'
require 'uri'
require 'pp'

#connpassAPIをたたくHTTPクライアント

url = URI.parse('http://connpass.com/api/v1/event/?keyword=python ')
res = Net::HTTP.start(url.host, url.port) {|http|
  http.get('/?keyword=python ')
}
pp res
