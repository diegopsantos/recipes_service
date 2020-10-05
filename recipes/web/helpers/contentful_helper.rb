# frozen_string_literal: true

require 'contentful'
require 'contentful_service'

module ContentfulHelper
  CLIENT = Contentful::Client.new(
    access_token: ENV.fetch('CONTENTFUL_ACCESS_TOKEN'),
    space: ENV.fetch('CONTENTFUL_SPACE', 'kk2bw5ojx476'),
    environment: 'master'
  )


  def contentful_service
     @service ||= ContentfulService.new(CLIENT)
  end
end