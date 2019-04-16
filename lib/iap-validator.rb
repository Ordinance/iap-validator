require "iap-validator/version"

require 'httparty'
require 'multi_json'

module IAPValidator
  class IAPValidator
    include HTTParty

    SANDBOX_URL = 'https://sandbox.itunes.apple.com'
    PRODUCTION_URL = 'https://buy.itunes.apple.com'

    base_uri PRODUCTION_URL

    headers 'Content-Type' => 'application/json'
    format :json

    def self.validate(data, sandbox = false, password = nil, &on_error)
      base_uri SANDBOX_URL if sandbox

      json = password.nil? ?
        { 'receipt-data' => data } :
        { 'receipt-data' => data, 'password' => password }

      resp = post('/verifyReceipt', :body => MultiJson.encode(json))

      if resp.code == 200
        MultiJson.decode(resp.body())
      else
        on_error.call(resp) if block_given?
        nil
      end
    end

    def self.valid?(data, sandbox = false)
      resp = validate(data, sandbox)
      !resp.nil? && resp['status'] == 0
    end
  end
end
