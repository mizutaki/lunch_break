require 'clockwork'
require_relative 'event_search_job'
module Clockwork
  handler do |job|
    job.call
  end

  every(1.minutes, EventSearchJob.new)
end