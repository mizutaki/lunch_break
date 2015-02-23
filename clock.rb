require 'clockwork'
require_relative 'http_request.rb'
module Clockwork
  handler do |job|
    job.call
  end

  every(1.seconds, HTTPRequest.new)
end