# frozen_string_literal: true
require 'json'

module IAPValidator
  class Receipt
      # https://developer.apple.com/documentation/appstorereceipts/responsebody
      ATTRIBUTES = %i[
        environment is_retryable latest_receipt latest_receipt_info pending_renewal_info
        original_response receipt status
      ].freeze

      attr_reader(*ATTRIBUTES)

    def initialize(response)
      self.original_response    = response
      self.environment          = response&.dig('environment')
      self.is_retryable         = response&.dig('is-retryable')
      self.latest_receipt       = response&.dig('latest_receipt')
      self.latest_receipt_info  = response&.dig('latest_receipt_info')
      self.pending_renewal_info = response&.dig('pending_renewal_info')
      self.receipt              = response&.dig('receipt')
      self.status               = response&.dig('status')
    end

    class << self
      def verify(data, options = {})
        client = options[:sandbox] ? Client.development : Client.production
        puts "33333"
        p client.to_json
        puts "33333"
        client.verify_receipt(data, options)
      end
    end
    
    private

    attr_writer(*ATTRIBUTES)
  end
end