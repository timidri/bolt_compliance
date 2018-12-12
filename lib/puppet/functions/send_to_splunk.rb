#!/usr/bin/env ruby
require 'net/http'
require 'net/https'
require 'openssl'
require 'json'

# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

Puppet::Functions.create_function(:send_to_splunk) do
  dispatch :send_to_splunk do
    param 'Hash', :data
    param 'String[1]', :splunk_uri
    param 'String[1]', :splunk_endpoint
    param 'Boolean', :verbose
    return_type 'String[1]'
  end

  def send_to_splunk(data, splunk_endpoint, splunk_token, verbose)
    uri = URI(splunk_endpoint)
    request = Net::HTTP::Post.new(uri)
    request.add_field('Authorization', "Splunk #{splunk_token}")
    request.add_field('Content-Type', 'application/json')
    request.body = { event: data }.to_json

    options = {
      use_ssl: uri.scheme == 'https',
      verify_mode: OpenSSL::SSL::VERIFY_NONE,
    }

    response = nil
    Net::HTTP.start(uri.hostname, uri.port, options) do |http|
      if verbose
        puts "uri: #{uri}, options: #{options}, request: #{request.body}"
      end
      response = http.request(request)
    end
    response.body
  end
end
